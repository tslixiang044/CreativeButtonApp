/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"

//static void * MyObjectMyCustomPorpertyKey = (void *)@"MyObjectMyCustomPorpertyKey";

@implementation UIImageView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self setImageWithURL:url placeholderImage:placeholder options:0];
}

- (void)setImageWithURL2:(NSURL *)url placeholderImage_day:(UIImage *)placeholder_day placeholderImage_night:(UIImage *)placeholder_night
{
    
}


//设置图片并将图片转换为正方形图片
- (void)setImageWithURL3:(NSURL *)url placeholderImage_day:(UIImage *)placeholder_day placeholderImage_night:(UIImage *)placeholder_night andImgConvertType:(int)type
{
    //占用tag 3333 . 3334
    
    self.tag = 3333 + type;
    [self setImageWithURL2:url placeholderImage_day:placeholder_day placeholderImage_night:placeholder_night];
}




 

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    self.image = placeholder;

    if (url)
    {
        [manager downloadWithURL:url delegate:self options:options];
    }
}

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
   // NSLog(@"img_width=%f     height=%f      tag=%i",image.size.width,image.size.height,self.tag);

    self.image = image;

}





@end
