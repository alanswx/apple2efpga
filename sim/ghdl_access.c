/* ghdl_access.c
*/
#include <stdio.h>
#ifdef _WIN32
#include "SDL.h"
#else
#include <SDL2/SDL.h>
#endif

SDL_GameController* gGameController = NULL;
Uint32 * pixels;
SDL_Renderer * renderer =NULL;
SDL_Texture * texture =NULL;
static int rows, cols;
static unsigned int row_sink, col_sink;
//static unsigned int col_hsync, row_vsync;
static unsigned int old_hsync, old_vsync;
static unsigned int pw_hsync, pw_vsync;
static int show_vis;
static int show_stats;
static struct {
    int hpol, vpol;
    unsigned int pw_hsync_hi, pw_hsync_lo;
    unsigned int pw_vsync_hi, pw_vsync_lo;
    unsigned int cols_h, rows_v, cols_hsync, rows_vsync;

} stats;

static void init_stats(void)
{
    stats.hpol = -1;
    stats.vpol = -1;
    stats.cols_h = -1;
    stats.rows_v = -1;
    stats.cols_hsync = -1;
    stats.rows_vsync = -1;
}

static void dump_stats(void)
{
    printf("vga: ");
    printf("hpol:%s ", stats.hpol >= 0 ? (stats.hpol > 0 ? "+" : "-") : "unknown");
    printf("vpol:%s ", stats.vpol >= 0 ? (stats.vpol > 0 ? "+" : "-") : "unknown");
    printf("hpw: hi%d lo%d ", stats.pw_hsync_hi, stats.pw_hsync_lo);
    printf("vpw: hi%d lo%d ", stats.pw_vsync_hi, stats.pw_vsync_lo);
    printf("hcols:%d ", stats.cols_h);
    printf("hcols-sync:%d ", stats.cols_hsync);
    printf("vlines:%d ", stats.rows_v);
    printf("vlines-sync:%d ", stats.rows_vsync);
    printf("\n");
}




void dpi_vga_init(int width, int height)
{
    int flags;

    cols =width;
    rows = height;
    show_vis = 0;
    show_stats = 0;

   printf("dpi_vga_init: %d %d \n",width,height);
    printf("Initialize display %dx%d\n", cols, rows);

    flags = SDL_INIT_VIDEO | SDL_INIT_JOYSTICK;

    if (SDL_Init(flags)) {
        printf("SDL initialization failed\n");
        return;
    }

    //Check for joysticks
    if( SDL_NumJoysticks() < 1 )
    {
            printf( "Warning: No joysticks connected!\n" );
    }
    else
    {
            //Load joystick
            gGameController = SDL_GameControllerOpen( 0 );
            if( gGameController == NULL )
            {
                printf( "Warning: Unable to open game controller! SDL Error: %s\n", SDL_GetError() );
            }
    }

    /* NOTE: we still want Ctrl-C to work - undo the SDL redirections*/
    signal(SIGINT, SIG_DFL);
    signal(SIGQUIT, SIG_DFL);
    SDL_Window * window = SDL_CreateWindow("SDL2 Pixel Drawing",
        SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, cols, rows, 0);

    if (!window) {
        printf("Could not open SDL display\n");
        return;
    }


   SDL_PumpEvents();

    renderer = SDL_CreateRenderer(window, -1, 0);
    // the texture should match the GPU so it doesn't have to copy
    texture = SDL_CreateTexture(renderer,
        SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STATIC, cols, rows);
    pixels = (Uint32 *)calloc(sizeof(Uint32),rows*cols);
fprintf(stderr,"%d %d %d %d\n",(sizeof(Uint32)*rows*cols),sizeof(Uint32),rows,cols);
    memset(pixels, 255, cols* rows* sizeof(Uint32));

    row_sink = 0;
    col_sink = 0;
//    col_hsync = 0;
//    row_vsync = 0;

    init_stats();
}
void dpi_vga_display(int vsync, int hsync, unsigned int pixel)
{
   //printf("dpi_vga_display: %x %x %x\n",vsync,hsync,pixel);
    int offset, hedge, vedge;

   pixel = pixel | 0xFF000000;
   //printf("dpi_vga_display: %x %x %x\n",vsync,hsync,pixel);
    if(texture== NULL) {
        printf("Error: display not initialized\n");
        return;
    }
    /* edge detect */
    hedge = 0;
    vedge = 0;

    if (vsync != old_vsync)
    {
        vedge++;

        if (vsync)
            stats.pw_vsync_lo = pw_vsync;
        else
            stats.pw_vsync_hi = pw_vsync;

        /* record polarity if we have not yet */
        if (stats.vpol < 0 && stats.pw_vsync_lo && stats.pw_vsync_hi) {
            if (stats.pw_vsync_lo > stats.pw_vsync_hi)
                stats.vpol = +1;
            else
                if (stats.pw_vsync_lo < stats.pw_vsync_hi)
                    stats.vpol = 0;
        }

        old_vsync = vsync;
        pw_vsync = 0;
    } else
        pw_vsync++;
    if (hsync != old_hsync) {
        hedge++;
{
SDL_Event event;
   SDL_PumpEvents();
    if (SDL_PollEvent( & event)) {
        if (event.type == SDL_QUIT) {
            //isquit = true;
        }
    }
}

        if (hsync)
            stats.pw_hsync_lo = pw_hsync;
        else
            stats.pw_hsync_hi = pw_hsync;

        /* record polarity if we have not yet */
        if (stats.hpol < 0 && stats.pw_hsync_lo > 0 && stats.pw_hsync_hi > 0) {
            if (stats.pw_hsync_lo > stats.pw_hsync_hi)
                stats.hpol = +1;
            else
                if (stats.pw_hsync_lo < stats.pw_hsync_hi)
                    stats.hpol = 0;
        }

        old_hsync = hsync;
        pw_hsync = 0;
    } else
        pw_hsync++;
    /* end of vblank? */
    if (vedge) {
        if (vsync != stats.vpol) {
            /* end of pulse */
            if (show_vis) printf("vga: visable lines %d\n", row_sink);
            if (1) printf("Frame Complete\n");
            if (show_stats) dump_stats();
#if 1
        SDL_RenderClear(renderer);
        SDL_RenderCopy(renderer, texture, NULL, NULL);
        SDL_RenderPresent(renderer);
        SDL_UpdateTexture(texture, NULL, pixels,cols * sizeof(Uint32));

SDL_Event event;
   SDL_PumpEvents();
    if (SDL_PollEvent( & event)) {
        if (event.type == SDL_QUIT) {
            //isquit = true;
        }
    }
#endif

            stats.rows_vsync = row_sink - stats.rows_v + 1;
            row_sink = col_sink = 0;
            return;
        } else {
            stats.rows_v = row_sink;
        }
    }

    /* end of hblank? */
    if (hedge) {
        if (hsync != stats.hpol) {
            /* end of pulse */
            if (show_vis) printf("vga: visable h pixels %d\n", col_sink);
            row_sink++;
            stats.cols_hsync = col_sink - stats.cols_h + 1;
            col_sink = 0;
            return;
        } else {
            stats.cols_h = col_sink;
        }
    }
    if (col_sink >= cols ||
        row_sink >= rows)
        return;

    /* do it */
    offset = (row_sink * cols) + col_sink;

    if (pixel & 0) printf("vga: pixel[%d,%d %d] <- %x\n", row_sink, col_sink, offset, pixel);

    pixels[offset] = pixel|0x000F;

    col_sink++;
}
