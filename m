Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 299F2C055D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 14:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfI0MmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 08:42:15 -0400
Received: from foss.arm.com ([217.140.110.172]:51280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfI0MmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:42:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3952D1000;
        Fri, 27 Sep 2019 05:42:14 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F13E73F67D;
        Fri, 27 Sep 2019 05:42:13 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id AA07268295D; Fri, 27 Sep 2019 13:42:12 +0100 (BST)
Date:   Fri, 27 Sep 2019 13:42:12 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2 1/2] drm/komeda: Add line size support
Message-ID: <20190927124212.gwi65bjxkgrgvqsa@e110455-lin.cambridge.arm.com>
References: <20190924080022.19250-1-lowry.li@arm.com>
 <20190924080022.19250-2-lowry.li@arm.com>
 <20190925102456.njecolasjwsfrvel@e110455-lin.cambridge.arm.com>
 <20190926100016.GA32449@lowli01-ThinkStation-P300>
 <20190926115120.utnhcf5hw4sebixd@e110455-lin.cambridge.arm.com>
 <20190927020253.GA11183@jamwan02-TSP300>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190927020253.GA11183@jamwan02-TSP300>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 02:02:59AM +0000, james qian wang (Arm Technology China) wrote:
> On Thu, Sep 26, 2019 at 11:51:21AM +0000, Liviu Dudau wrote:
> > On Thu, Sep 26, 2019 at 10:00:22AM +0000, Lowry Li (Arm Technology China) wrote:
> > > Hi Lowry,
> > > On Wed, Sep 25, 2019 at 10:24:58AM +0000, Liviu Dudau wrote:
> > > > Hi Lowry,
> > > > 
> > > > On Tue, Sep 24, 2019 at 08:00:44AM +0000, Lowry Li (Arm Technology China) wrote:
> > > > > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> > > > > 
> > > > > On D71, we are using the global line size. From D32, every
> > > > > component have a line size register to indicate the fifo size.
> > > > > 
> > > > > So this patch is to set line size support and do the line size
> > > > > check.
> > > > > 
> > > > > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > > > > ---
> > > > >  .../arm/display/komeda/d71/d71_component.c    | 57 ++++++++++++++++---
> > > > >  .../gpu/drm/arm/display/komeda/d71/d71_regs.h |  9 +--
> > > > >  .../drm/arm/display/komeda/komeda_pipeline.h  |  2 +
> > > > >  .../display/komeda/komeda_pipeline_state.c    | 17 ++++++
> > > > >  4 files changed, 70 insertions(+), 15 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > > index 7b374a3b911e..357837b9d6ed 100644
> > > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > > @@ -106,6 +106,23 @@ static void dump_block_header(struct seq_file *sf, void __iomem *reg)
> > > > >  			   i, hdr.output_ids[i]);
> > > > >  }
> > > > >  
> > > > > +/* On D71, we are using the global line size. From D32, every component have
> > > > > + * a line size register to indicate the fifo size.
> > > > > + */
> > > > > +static u32 __get_blk_line_size(struct d71_dev *d71, u32 __iomem *reg,
> > > > > +			       u32 max_default)
> > > > > +{
> > > > > +	if (!d71->periph_addr)
> > > > > +		max_default = malidp_read32(reg, BLK_MAX_LINE_SIZE);
> > > > > +
> > > > > +	return max_default;
> > > > > +}
> > > > > +
> > > > > +static u32 get_blk_line_size(struct d71_dev *d71, u32 __iomem *reg)
> > > > > +{
> > > > > +	return __get_blk_line_size(d71, reg, d71->max_line_size);
> > > > > +}
> > > > 
> > > > I know you're trying to save typing the extra parameter, but looking at the rest of
> > > > the diff I think it would look better if you get rid of get_blk_line_size() function
> > > > and use the name for the function with 3 parameters.
> > > > 
> > > > Otherwise, patch looks good to me.
> > > > 
> > > > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> > > > 
> > > > Best regards,
> > > > Liviu
> > > Thanks for the comments.
> > > But considering from D32 every component have a line size register
> > > and no need default value, so we have get_blk_line_size() without
> > > default argument and also can save some typing and lines. That's
> > > why we want to keep __get_blk_line_size().
> > 
> > I was suggesting to remove get_blk_line_size and only use __get_blk_line_size() with
> > explicit use of d71->max_line_size where it makes sense.
> >
> 
> Hi Liviu:

Hi James,

> 
> Thank you for the suggestion.
> 
> Seems lowry doesn't describe it clearly.
> 
> the stroy is like this, for current komeda products:
> 
> - D71: Doesn't have per component line_size register to indicate the
>        fifo size.
>        And the fifo size is quite customized for every component,
>        Alought for HW it is just a const value. but since it doesn't exposed
>        to SW. So for driver It's quite annoy&hard to judage via lots of hints. 
> 
> - D32 or newer: have line_size register.
> 
> So for compatible with these two class products, we defined two functions:
> 
> - __get_blk_line_size():
> 
>   for d71 specific component like spliter/merger, that's why here we
>   need input a default line_size, since all d71 specific component
>   doesn't have its own line_size register or can not be indicated via
>   the register GCU->line_size.
>   Need to set it manually according to the specific component and lots
>   of hints.
> 
> - get_blk_line_size(): 
> 
>   Two cases:
>   -- d32 or newer: which have its own fifo line_size register
>   -- d71: the line_size always same as the GCU->line_size
>           register (the d71->max_line_size) 
> 
> So last as a conclusion:
> 
> - get_blk_line_size():
>   is for the component that line_size can be indicated by HW line_size register,
>   no matter component->line_size or GCU->line_size.

Then call it get_hw_blk_line_size() :) But at the moment all it does is to call
__get_blk_line_size() with a well defined 3rd parameter.

> 
> - __get_blk_line_size():
>   for the d71 specific componet that needs manually calculate the line_size.

All I'm saying is that you could use __get_blk_line_size() everywhere and the diff
would look nicer because you could see that the same parameters are used.

We are also removing nice names that express what the values are with the actual
number, loosing some of the meta information that we had in the code.

From maintainability perspective I would say this patch does not help future
reviewers of the code.

Best regards,
Liviu

> 
> Thanks
> James
> 
> > Best regards,
> > Liviu
> > 
> > > 
> > > > > +
> > > > >  static u32 to_rot_ctrl(u32 rot)
> > > > >  {
> > > > >  	u32 lr_ctrl = 0;
> > > > > @@ -365,7 +382,28 @@ static int d71_layer_init(struct d71_dev *d71,
> > > > >  	else
> > > > >  		layer->layer_type = KOMEDA_FMT_SIMPLE_LAYER;
> > > > >  
> > > > > -	set_range(&layer->hsize_in, 4, d71->max_line_size);
> > > > > +	if (!d71->periph_addr) {
> > > > > +		/* D32 or newer product */
> > > > > +		layer->line_sz = malidp_read32(reg, BLK_MAX_LINE_SIZE);
> > > > > +		layer->yuv_line_sz = L_INFO_YUV_MAX_LINESZ(layer_info);
> > > > > +	} else if (d71->max_line_size > 2048) {
> > > > > +		/* D71 4K */
> > > > > +		layer->line_sz = d71->max_line_size;
> > > > > +		layer->yuv_line_sz = layer->line_sz / 2;
> > > > > +	} else	{
> > > > > +		/* D71 2K */
> > > > > +		if (layer->layer_type == KOMEDA_FMT_RICH_LAYER) {
> > > > > +			/* rich layer is 4K configuration */
> > > > > +			layer->line_sz = d71->max_line_size * 2;
> > > > > +			layer->yuv_line_sz = layer->line_sz / 2;
> > > > > +		} else {
> > > > > +			layer->line_sz = d71->max_line_size;
> > > > > +			layer->yuv_line_sz = 0;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	set_range(&layer->hsize_in, 4, layer->line_sz);
> > > > > +
> > > > >  	set_range(&layer->vsize_in, 4, d71->max_vsize);
> > > > >  
> > > > >  	malidp_write32(reg, LAYER_PALPHA, D71_PALPHA_DEF_MAP);
> > > > > @@ -456,9 +494,11 @@ static int d71_wb_layer_init(struct d71_dev *d71,
> > > > >  
> > > > >  	wb_layer = to_layer(c);
> > > > >  	wb_layer->layer_type = KOMEDA_FMT_WB_LAYER;
> > > > > +	wb_layer->line_sz = get_blk_line_size(d71, reg);
> > > > > +	wb_layer->yuv_line_sz = wb_layer->line_sz;
> > > > >  
> > > > > -	set_range(&wb_layer->hsize_in, D71_MIN_LINE_SIZE, d71->max_line_size);
> > > > > -	set_range(&wb_layer->vsize_in, D71_MIN_VERTICAL_SIZE, d71->max_vsize);
> > > > > +	set_range(&wb_layer->hsize_in, 64, wb_layer->line_sz);
> > > > > +	set_range(&wb_layer->vsize_in, 64, d71->max_vsize);
> > > > >  
> > > > >  	return 0;
> > > > >  }
> > > > > @@ -595,8 +635,8 @@ static int d71_compiz_init(struct d71_dev *d71,
> > > > >  
> > > > >  	compiz = to_compiz(c);
> > > > >  
> > > > > -	set_range(&compiz->hsize, D71_MIN_LINE_SIZE, d71->max_line_size);
> > > > > -	set_range(&compiz->vsize, D71_MIN_VERTICAL_SIZE, d71->max_vsize);
> > > > > +	set_range(&compiz->hsize, 64, get_blk_line_size(d71, reg));
> > > > > +	set_range(&compiz->vsize, 64, d71->max_vsize);
> > > > >  
> > > > >  	return 0;
> > > > >  }
> > > > > @@ -753,7 +793,7 @@ static int d71_scaler_init(struct d71_dev *d71,
> > > > >  	}
> > > > >  
> > > > >  	scaler = to_scaler(c);
> > > > > -	set_range(&scaler->hsize, 4, 2048);
> > > > > +	set_range(&scaler->hsize, 4, __get_blk_line_size(d71, reg, 2048));
> > > > >  	set_range(&scaler->vsize, 4, 4096);
> > > > >  	scaler->max_downscaling = 6;
> > > > >  	scaler->max_upscaling = 64;
> > > > > @@ -862,7 +902,7 @@ static int d71_splitter_init(struct d71_dev *d71,
> > > > >  
> > > > >  	splitter = to_splitter(c);
> > > > >  
> > > > > -	set_range(&splitter->hsize, 4, d71->max_line_size);
> > > > > +	set_range(&splitter->hsize, 4, get_blk_line_size(d71, reg));
> > > > >  	set_range(&splitter->vsize, 4, d71->max_vsize);
> > > > >  
> > > > >  	return 0;
> > > > > @@ -933,7 +973,8 @@ static int d71_merger_init(struct d71_dev *d71,
> > > > >  
> > > > >  	merger = to_merger(c);
> > > > >  
> > > > > -	set_range(&merger->hsize_merged, 4, 4032);
> > > > > +	set_range(&merger->hsize_merged, 4,
> > > > > +		  __get_blk_line_size(d71, reg, 4032));
> > > > >  	set_range(&merger->vsize_merged, 4, 4096);
> > > > >  
> > > > >  	return 0;
> > > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > > > > index 2d5e6d00b42c..1727dc993909 100644
> > > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > > > > @@ -10,6 +10,7 @@
> > > > >  /* Common block registers offset */
> > > > >  #define BLK_BLOCK_INFO		0x000
> > > > >  #define BLK_PIPELINE_INFO	0x004
> > > > > +#define BLK_MAX_LINE_SIZE	0x008
> > > > >  #define BLK_VALID_INPUT_ID0	0x020
> > > > >  #define BLK_OUTPUT_ID0		0x060
> > > > >  #define BLK_INPUT_ID0		0x080
> > > > > @@ -321,6 +322,7 @@
> > > > >  #define L_INFO_RF		BIT(0)
> > > > >  #define L_INFO_CM		BIT(1)
> > > > >  #define L_INFO_ABUF_SIZE(x)	(((x) >> 4) & 0x7)
> > > > > +#define L_INFO_YUV_MAX_LINESZ(x)	(((x) >> 16) & 0xFFFF)
> > > > >  
> > > > >  /* Scaler registers */
> > > > >  #define SC_COEFFTAB		0x0DC
> > > > > @@ -494,13 +496,6 @@ enum d71_blk_type {
> > > > >  #define D71_DEFAULT_PREPRETCH_LINE	5
> > > > >  #define D71_BUS_WIDTH_16_BYTES		16
> > > > >  
> > > > > -#define D71_MIN_LINE_SIZE		64
> > > > > -#define D71_MIN_VERTICAL_SIZE		64
> > > > > -#define D71_SC_MIN_LIN_SIZE		4
> > > > > -#define D71_SC_MIN_VERTICAL_SIZE	4
> > > > > -#define D71_SC_MAX_LIN_SIZE		2048
> > > > > -#define D71_SC_MAX_VERTICAL_SIZE	4096
> > > > > -
> > > > >  #define D71_SC_MAX_UPSCALING		64
> > > > >  #define D71_SC_MAX_DOWNSCALING		6
> > > > >  #define D71_SC_SPLIT_OVERLAP		8
> > > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > > index 910d279ae48d..92aba58ce2a5 100644
> > > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > > @@ -227,6 +227,8 @@ struct komeda_layer {
> > > > >  	/* accepted h/v input range before rotation */
> > > > >  	struct malidp_range hsize_in, vsize_in;
> > > > >  	u32 layer_type; /* RICH, SIMPLE or WB */
> > > > > +	u32 line_sz;
> > > > > +	u32 yuv_line_sz; /* maximum line size for YUV422 and YUV420 */
> > > > >  	u32 supported_rots;
> > > > >  	/* komeda supports layer split which splits a whole image to two parts
> > > > >  	 * left and right and handle them by two individual layer processors
> > > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > > > > index 5526731f5a33..6df442666cfe 100644
> > > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > > > > @@ -285,6 +285,7 @@ komeda_layer_check_cfg(struct komeda_layer *layer,
> > > > >  		       struct komeda_data_flow_cfg *dflow)
> > > > >  {
> > > > >  	u32 src_x, src_y, src_w, src_h;
> > > > > +	u32 line_sz, max_line_sz;
> > > > >  
> > > > >  	if (!komeda_fb_is_layer_supported(kfb, layer->layer_type, dflow->rot))
> > > > >  		return -EINVAL;
> > > > > @@ -314,6 +315,22 @@ komeda_layer_check_cfg(struct komeda_layer *layer,
> > > > >  		return -EINVAL;
> > > > >  	}
> > > > >  
> > > > > +	if (drm_rotation_90_or_270(dflow->rot))
> > > > > +		line_sz = dflow->in_h;
> > > > > +	else
> > > > > +		line_sz = dflow->in_w;
> > > > > +
> > > > > +	if (kfb->base.format->hsub > 1)
> > > > > +		max_line_sz = layer->yuv_line_sz;
> > > > > +	else
> > > > > +		max_line_sz = layer->line_sz;
> > > > > +
> > > > > +	if (line_sz > max_line_sz) {
> > > > > +		DRM_DEBUG_ATOMIC("Required line_sz: %d exceeds the max size %d\n",
> > > > > +				 line_sz, max_line_sz);
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > -- 
> > > > > 2.17.1
> > > > > 
> > > > 
> > > > -- 
> > > > ====================
> > > > | I would like to |
> > > > | fix the world,  |
> > > > | but they're not |
> > > > | giving me the   |
> > > >  \ source code!  /
> > > >   ---------------
> > > >     ¯\_(ツ)_/¯
> > 
> > -- 
> > ====================
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ¯\_(ツ)_/¯

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
