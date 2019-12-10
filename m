Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A357A119063
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 20:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfLJTNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 14:13:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37314 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfLJTNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:13:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so9347755pga.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 11:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fzyJdxEkRkXN3PnMPhqA/O7Yt9Gr29cLh0NszcoBVg4=;
        b=ciyXAInnRtyVNIZa4K3x3etkO8M81JqViyEe+R6hhxWl3euGouJpR4gxYPWpMRiuya
         jF7KZpbB/D8LiOnKYrSdX6KJxm6G6Sw0kcY7DnJ9x9O66qUBXvkHh9cUWPRf6cwALZtH
         TlLnn1lIHOTLFdQqCfpls9AsDy1nJsoE+17aOqOf6rFL9SZAaF/PQ8nS9AUj7xkCSk++
         XImlqPekKX15YhCDHLeWiJs2omgrFNiTdHwUS5KmNIf/ZQFGid7Z2OIk06XEMT/Kb4Gl
         m+0PWS9UWUQYJsO19HR9XFG0tdxWe1e6to91U+Tp0Q61QLIrh9p2zLlla1DEgGX7enUK
         9YpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fzyJdxEkRkXN3PnMPhqA/O7Yt9Gr29cLh0NszcoBVg4=;
        b=l++hF5rq6LlrmcuJpuv9EI7NBb2/jPGrHix0TS0mbqSnV1dFr+51BaTuR7oIUYU2rW
         y552IiYB6hBiratLWVlJ5+emeIsZr4MdZGUCosjhBg+qxcBNxcg5ncTvvpCCG+Lqlwuq
         Zajb82UisEchKR1nGEohG93NCJ0hwy3y7ur1g4LPFiBz5b+VSar+o8pzBTUOK5i6qK8x
         zUia20YSOD/mvCI7Hbh/neKWwaklD4cdB/vHahUsVPBzlywFKqRDwQfsLOaNFtodTGCA
         G79ErSiJST/oibS/AwYSQtL0E8EDfpGUThQzLhXqaJK983F8Jd4pR7DPiH3fRfMoVx8k
         hSsg==
X-Gm-Message-State: APjAAAVQRNBEeQ6ocXc7O4mnYKIudupbQ4hyUqnwWY50yP+ECHCKcPp7
        kEY79ofqZioUwHhzCoFtFZamgQ==
X-Google-Smtp-Source: APXvYqzF6nEf2X/qHXLFiX5VFn8Ug6OE5V0B84YZf071zouP35lZe2qCC8vYOha0eVdBCqgg5n6q3g==
X-Received: by 2002:aa7:8f33:: with SMTP id y19mr35621399pfr.47.1576005220344;
        Tue, 10 Dec 2019 11:13:40 -0800 (PST)
Received: from google.com ([2620:0:1000:2511:b34b:87b6:d099:91b0])
        by smtp.gmail.com with ESMTPSA id g26sm4311441pfo.128.2019.12.10.11.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 11:13:39 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:13:35 -0800
From:   Tom Anderson <thomasanderson@google.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>,
        Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Pau <sean@poorly.run>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/edid: Add modes from CTA-861-G
Message-ID: <20191210191335.GA24292@google.com>
References: <20191123055053.154550-1-thomasanderson@google.com>
 <fcba3169-13a1-6368-60c6-bfc9d9ad62c1@amd.com>
 <c1870c44-466f-cbc3-25fa-47c3f4ec458d@amd.com>
 <20191202233246.GA49251@google.com>
 <20191203125312.GM1208@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203125312.GM1208@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 02:53:12PM +0200, Ville Syrjälä wrote:
> On Mon, Dec 02, 2019 at 03:32:46PM -0800, Tom Anderson wrote:
> > On Mon, Nov 25, 2019 at 01:42:00PM -0500, Bhawanpreet Lakha wrote:
> > > Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> > 
> > Thank you for the review. +Ville has brought to my attention 978f6b0693c7 which
> > added modes up to 128 which was part of a recent merge, so I didn't seen the
> > changes until now.
> > 
> > Ville also pointed out [1] which achieves the same thing, but has been in limbo.
> > At any rate, I'll be sending out a rebased v2 patch. I don't mind which patch
> > lands, all I want is for my 8K display to work :)
> 
> I'd just need someone to slap on a reviwed-by for the few patches
> that are missing it. I'd rather not waste ~13 KiB of memory for
> those 128-192 dummy modes, which is why I prefer my apporach.

Like I said, I'm fine with either patch landing. But in your patch, please merge
the drm_connector.h changes from here, otherwise there's a buffer overflow.

> 
> > 
> > [1] https://patchwork.freedesktop.org/series/63555/
> > 
> > > 
> > > On 2019-11-25 1:14 p.m., Harry Wentland wrote:
> > > > +Bhawan who has been looking at this from our side.
> > > > 
> > > > Harry
> > > > 
> > > > On 2019-11-23 12:50 a.m., Thomas Anderson wrote:
> > > > > The new modes are needed for exotic displays such as 8K. Verified that
> > > > > modes like 8K60 and 4K120 are properly obtained from a Samsung Q900R.
> > > > > 
> > > > > Signed-off-by: Thomas Anderson <thomasanderson@google.com>
> > > > > ---
> > > > >   drivers/gpu/drm/drm_edid.c  | 388 +++++++++++++++++++++++++++++++++++-
> > > > >   include/drm/drm_connector.h |  16 +-
> > > > >   2 files changed, 391 insertions(+), 13 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > > > > index 6b0177112e18..ff5c928516fb 100644
> > > > > --- a/drivers/gpu/drm/drm_edid.c
> > > > > +++ b/drivers/gpu/drm/drm_edid.c
> > > > > @@ -1278,6 +1278,374 @@ static const struct drm_display_mode edid_cea_modes[] = {
> > > > >   		   4104, 4400, 0, 2160, 2168, 2178, 2250, 0,
> > > > >   		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > >   	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 108 - 1280x720@48Hz 16:9 */
> > > > > +	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 90000, 1280, 2240,
> > > > > +		   2280, 2500, 0, 720, 725, 730, 750, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 109 - 1280x720@48Hz 64:27 */
> > > > > +	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 90000, 1280, 2240,
> > > > > +		   2280, 2500, 0, 720, 725, 730, 750, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 110 - 1680x720@48Hz 64:27 */
> > > > > +	{ DRM_MODE("1680x720", DRM_MODE_TYPE_DRIVER, 99000, 1680, 2490,
> > > > > +		   2530, 2750, 0, 720, 725, 730, 750, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 111 - 1920x1080@48Hz 16:9 */
> > > > > +	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 148500, 1920, 2558,
> > > > > +		   2602, 2750, 0, 1080, 1084, 1089, 1125, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 112 - 1920x1080@48Hz 64:27 */
> > > > > +	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 148500, 1920, 2558,
> > > > > +		   2602, 2750, 0, 1080, 1084, 1089, 1125, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 113 - 2560x1080@48Hz 64:27 */
> > > > > +	{ DRM_MODE("2560x1080", DRM_MODE_TYPE_DRIVER, 198000, 2560, 3558,
> > > > > +		   3602, 3750, 0, 1080, 1084, 1089, 1100, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 114 - 3840x2160@48Hz 16:9 */
> > > > > +	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 594000, 3840, 5116,
> > > > > +		   5204, 5500, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 115 - 4096x2160@48Hz 256:135 */
> > > > > +	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 594000, 4096, 5116,
> > > > > +		   5204, 5500, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48,
> > > > > +	  .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
> > > > > +	/* 116 - 3840x2160@48Hz 64:27 */
> > > > > +	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 594000, 3840, 5116,
> > > > > +		   5204, 5500, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 117 - 3840x2160@100Hz 16:9 */
> > > > > +	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 1188000, 3840, 4896,
> > > > > +		   4984, 5280, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 118 - 3840x2160@120Hz 16:9 */
> > > > > +	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 1188000, 3840, 4016,
> > > > > +		   4104, 4400, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 119 - 3840x2160@100Hz 64:27 */
> > > > > +	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 1188000, 3840, 4896,
> > > > > +		   4984, 5280, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 120 - 3840x2160@120Hz 64:27 */
> > > > > +	{ DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 1188000, 3840, 4016,
> > > > > +		   4104, 4400, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 121 - 5120x2160@24Hz 64:27 */
> > > > > +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 396000, 5120, 7116,
> > > > > +		   7204, 7500, 0, 2160, 2168, 2178, 2200, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 122 - 5120x2160@25Hz 64:27 */
> > > > > +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 396000, 5120, 6816,
> > > > > +		   6904, 7200, 0, 2160, 2168, 2178, 2200, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 123 - 5120x2160@30Hz 64:27 */
> > > > > +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 396000, 5120, 5784,
> > > > > +		   5872, 6000, 0, 2160, 2168, 2178, 2200, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 124 - 5120x2160@48Hz 64:27 */
> > > > > +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 742500, 5120, 5866,
> > > > > +		   5954, 6250, 0, 2160, 2168, 2178, 2475, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 125 - 5120x2160@50Hz 64:27 */
> > > > > +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 742500, 5120, 6216,
> > > > > +		   6304, 6600, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 126 - 5120x2160@60Hz 64:27 */
> > > > > +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 742500, 5120, 5284,
> > > > > +		   5372, 5500, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 127 - 5120x2160@100Hz 64:27 */
> > > > > +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 1485000, 5120, 6216,
> > > > > +		   6304, 6600, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 128 - dummy */
> > > > > +	{ },
> > > > > +	/* 129 - reserved for native timing 1 */
> > > > > +	{ },
> > > > > +	/* 130 - reserved for native timing 2 */
> > > > > +	{ },
> > > > > +	/* 131 - reserved for native timing 3 */
> > > > > +	{ },
> > > > > +	/* 132 - reserved for native timing 4 */
> > > > > +	{ },
> > > > > +	/* 133 - reserved for native timing 5 */
> > > > > +	{ },
> > > > > +	/* 134 - reserved for native timing 6 */
> > > > > +	{ },
> > > > > +	/* 135 - reserved for native timing 7 */
> > > > > +	{ },
> > > > > +	/* 136 - reserved for native timing 8 */
> > > > > +	{ },
> > > > > +	/* 137 - reserved for native timing 9 */
> > > > > +	{ },
> > > > > +	/* 138 - reserved for native timing 10 */
> > > > > +	{ },
> > > > > +	/* 139 - reserved for native timing 11 */
> > > > > +	{ },
> > > > > +	/* 140 - reserved for native timing 12 */
> > > > > +	{ },
> > > > > +	/* 141 - reserved for native timing 13 */
> > > > > +	{ },
> > > > > +	/* 142 - reserved for native timing 14 */
> > > > > +	{ },
> > > > > +	/* 143 - reserved for native timing 15 */
> > > > > +	{ },
> > > > > +	/* 144 - reserved for native timing 16 */
> > > > > +	{ },
> > > > > +	/* 145 - reserved for native timing 17 */
> > > > > +	{ },
> > > > > +	/* 146 - reserved for native timing 18 */
> > > > > +	{ },
> > > > > +	/* 147 - reserved for native timing 19 */
> > > > > +	{ },
> > > > > +	/* 148 - reserved for native timing 20 */
> > > > > +	{ },
> > > > > +	/* 149 - reserved for native timing 21 */
> > > > > +	{ },
> > > > > +	/* 150 - reserved for native timing 22 */
> > > > > +	{ },
> > > > > +	/* 151 - reserved for native timing 23 */
> > > > > +	{ },
> > > > > +	/* 152 - reserved for native timing 24 */
> > > > > +	{ },
> > > > > +	/* 153 - reserved for native timing 25 */
> > > > > +	{ },
> > > > > +	/* 154 - reserved for native timing 26 */
> > > > > +	{ },
> > > > > +	/* 155 - reserved for native timing 27 */
> > > > > +	{ },
> > > > > +	/* 156 - reserved for native timing 28 */
> > > > > +	{ },
> > > > > +	/* 157 - reserved for native timing 29 */
> > > > > +	{ },
> > > > > +	/* 158 - reserved for native timing 30 */
> > > > > +	{ },
> > > > > +	/* 159 - reserved for native timing 31 */
> > > > > +	{ },
> > > > > +	/* 160 - reserved for native timing 32 */
> > > > > +	{ },
> > > > > +	/* 161 - reserved for native timing 33 */
> > > > > +	{ },
> > > > > +	/* 162 - reserved for native timing 34 */
> > > > > +	{ },
> > > > > +	/* 163 - reserved for native timing 35 */
> > > > > +	{ },
> > > > > +	/* 164 - reserved for native timing 36 */
> > > > > +	{ },
> > > > > +	/* 165 - reserved for native timing 37 */
> > > > > +	{ },
> > > > > +	/* 166 - reserved for native timing 38 */
> > > > > +	{ },
> > > > > +	/* 167 - reserved for native timing 39 */
> > > > > +	{ },
> > > > > +	/* 168 - reserved for native timing 40 */
> > > > > +	{ },
> > > > > +	/* 169 - reserved for native timing 41 */
> > > > > +	{ },
> > > > > +	/* 170 - reserved for native timing 42 */
> > > > > +	{ },
> > > > > +	/* 171 - reserved for native timing 43 */
> > > > > +	{ },
> > > > > +	/* 172 - reserved for native timing 44 */
> > > > > +	{ },
> > > > > +	/* 173 - reserved for native timing 45 */
> > > > > +	{ },
> > > > > +	/* 174 - reserved for native timing 46 */
> > > > > +	{ },
> > > > > +	/* 175 - reserved for native timing 47 */
> > > > > +	{ },
> > > > > +	/* 176 - reserved for native timing 48 */
> > > > > +	{ },
> > > > > +	/* 177 - reserved for native timing 49 */
> > > > > +	{ },
> > > > > +	/* 178 - reserved for native timing 50 */
> > > > > +	{ },
> > > > > +	/* 179 - reserved for native timing 51 */
> > > > > +	{ },
> > > > > +	/* 180 - reserved for native timing 52 */
> > > > > +	{ },
> > > > > +	/* 181 - reserved for native timing 53 */
> > > > > +	{ },
> > > > > +	/* 182 - reserved for native timing 54 */
> > > > > +	{ },
> > > > > +	/* 183 - reserved for native timing 55 */
> > > > > +	{ },
> > > > > +	/* 184 - reserved for native timing 56 */
> > > > > +	{ },
> > > > > +	/* 185 - reserved for native timing 57 */
> > > > > +	{ },
> > > > > +	/* 186 - reserved for native timing 58 */
> > > > > +	{ },
> > > > > +	/* 187 - reserved for native timing 59 */
> > > > > +	{ },
> > > > > +	/* 188 - reserved for native timing 60 */
> > > > > +	{ },
> > > > > +	/* 189 - reserved for native timing 61 */
> > > > > +	{ },
> > > > > +	/* 190 - reserved for native timing 62 */
> > > > > +	{ },
> > > > > +	/* 191 - reserved for native timing 63 */
> > > > > +	{ },
> > > > > +	/* 192 - reserved for native timing 64 */
> > > > > +	{ },
> > > > > +	/* 193 - 5120x2160@120Hz 64:27 */
> > > > > +	{ DRM_MODE("5120x2160", DRM_MODE_TYPE_DRIVER, 1485000, 5120, 5284,
> > > > > +		   5372, 5500, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 194 - 7680x4320@24Hz 16:9 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 10232,
> > > > > +		   10408, 11000, 0, 4320, 4336, 4356, 4500, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 195 - 7680x4320@25Hz 16:9 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 10032,
> > > > > +		   10208, 10800, 0, 4320, 4336, 4356, 4400, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 196 - 7680x4320@30Hz 16:9 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 8232,
> > > > > +		   8408, 9000, 0, 4320, 4336, 4356, 4400, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 197 - 7680x4320@48Hz 16:9 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 10232,
> > > > > +		   10408, 11000, 0, 4320, 4336, 4356, 4500, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 198 - 7680x4320@50Hz 16:9 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 10032,
> > > > > +		   10208, 10800, 0, 4320, 4336, 4356, 4400, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 199 - 7680x4320@60Hz 16:9 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 8232,
> > > > > +		   8408, 9000, 0, 4320, 4336, 4356, 4400, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 200 - 7680x4320@100Hz 16:9 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 4752000, 7680, 9792,
> > > > > +		   9968, 10560, 0, 4320, 4336, 4356, 4500, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 201 - 7680x4320@120Hz 16:9 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 4752000, 7680, 8032,
> > > > > +		   8208, 8800, 0, 4320, 4336, 4356, 4500, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
> > > > > +	/* 202 - 7680x4320@24Hz 64:27 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 10232,
> > > > > +		   10408, 11000, 0, 4320, 4336, 4356, 4500, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 203 - 7680x4320@25Hz 64:27 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 10032,
> > > > > +		   10208, 10800, 0, 4320, 4336, 4356, 4400, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 204 - 7680x4320@30Hz 64:27 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 1188000, 7680, 8232,
> > > > > +		   8408, 9000, 0, 4320, 4336, 4356, 4400, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 205 - 7680x4320@48Hz 64:27 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 10232,
> > > > > +		   10408, 11000, 0, 4320, 4336, 4356, 4500, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 206 - 7680x4320@50Hz 64:27 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 10032,
> > > > > +		   10208, 10800, 0, 4320, 4336, 4356, 4400, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 207 - 7680x4320@60Hz 64:27 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 2376000, 7680, 8232,
> > > > > +		   8408, 9000, 0, 4320, 4336, 4356, 4400, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 208 - 7680x4320@100Hz 64:27 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 4752000, 7680, 9792,
> > > > > +		   9968, 10560, 0, 4320, 4336, 4356, 4500, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 209 - 7680x4320@120Hz 64:27 */
> > > > > +	{ DRM_MODE("7680x4320", DRM_MODE_TYPE_DRIVER, 4752000, 7680, 8032,
> > > > > +		   8208, 8800, 0, 4320, 4336, 4356, 4500, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 210 - 10240x4320@24Hz 64:27 */
> > > > > +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 1485000, 10240, 11732,
> > > > > +		   11908, 12500, 0, 4320, 4336, 4356, 4950, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 24, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 211 - 10240x4320@25Hz 64:27 */
> > > > > +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 1485000, 10240, 12732,
> > > > > +		   12908, 13500, 0, 4320, 4336, 4356, 4400, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 25, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 212 - 10240x4320@30Hz 64:27 */
> > > > > +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 1485000, 10240, 10528,
> > > > > +		   10704, 11000, 0, 4320, 4336, 4356, 4500, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 30, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 213 - 10240x4320@48Hz 64:27 */
> > > > > +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 2970000, 10240, 11732,
> > > > > +		   11908, 12500, 0, 4320, 4336, 4356, 4950, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 48, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 214 - 10240x4320@50Hz 64:27 */
> > > > > +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 2970000, 10240, 12732,
> > > > > +		   12908, 13500, 0, 4320, 4336, 4356, 4400, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 50, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 215 - 10240x4320@60Hz 64:27 */
> > > > > +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 2970000, 10240, 10528,
> > > > > +		   10704, 11000, 0, 4320, 4336, 4356, 4500, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 216 - 10240x4320@100Hz 64:27 */
> > > > > +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 5940000, 10240, 12432,
> > > > > +		   12608, 13200, 0, 4320, 4336, 4356, 4500, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 100, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 217 - 10240x4320@120Hz 64:27 */
> > > > > +	{ DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 5940000, 10240, 10528,
> > > > > +		   10704, 11000, 0, 4320, 4336, 4356, 4500, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 120, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
> > > > > +	/* 218 - 4096x2160@100Hz 256:135 */
> > > > > +	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 1188000, 4096, 4896,
> > > > > +		   4984, 5280, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 100,
> > > > > +	  .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
> > > > > +	/* 219 - 4096x2160@120Hz 256:135 */
> > > > > +	{ DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 1188000, 4096, 4184,
> > > > > +		   4272, 4400, 0, 2160, 2168, 2178, 2250, 0,
> > > > > +		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > > > > +	  .vrefresh = 120,
> > > > > +	  .picture_aspect_ratio = HDMI_PICTURE_ASPECT_256_135, },
> > > > >   };
> > > > >   /*
> > > > > @@ -3030,6 +3398,12 @@ cea_mode_alternate_timings(u8 vic, struct drm_display_mode *mode)
> > > > >   	return false;
> > > > >   }
> > > > > +static bool drm_valid_cea_vic(u8 vic)
> > > > > +{
> > > > > +	return (vic > 0 && vic < 128) ||
> > > > > +	       (vic > 192 && vic < ARRAY_SIZE(edid_cea_modes));
> > > > > +}
> > > > > +
> > > > >   static u8 drm_match_cea_mode_clock_tolerance(const struct drm_display_mode *to_match,
> > > > >   					     unsigned int clock_tolerance)
> > > > >   {
> > > > > @@ -3046,6 +3420,9 @@ static u8 drm_match_cea_mode_clock_tolerance(const struct drm_display_mode *to_m
> > > > >   		struct drm_display_mode cea_mode = edid_cea_modes[vic];
> > > > >   		unsigned int clock1, clock2;
> > > > > +		if (!drm_valid_cea_vic(vic))
> > > > > +			continue;
> > > > > +
> > > > >   		/* Check both 60Hz and 59.94Hz */
> > > > >   		clock1 = cea_mode.clock;
> > > > >   		clock2 = cea_mode_alternate_clock(&cea_mode);
> > > > > @@ -3085,6 +3462,9 @@ u8 drm_match_cea_mode(const struct drm_display_mode *to_match)
> > > > >   		struct drm_display_mode cea_mode = edid_cea_modes[vic];
> > > > >   		unsigned int clock1, clock2;
> > > > > +		if (!drm_valid_cea_vic(vic))
> > > > > +			continue;
> > > > > +
> > > > >   		/* Check both 60Hz and 59.94Hz */
> > > > >   		clock1 = cea_mode.clock;
> > > > >   		clock2 = cea_mode_alternate_clock(&cea_mode);
> > > > > @@ -3103,11 +3483,6 @@ u8 drm_match_cea_mode(const struct drm_display_mode *to_match)
> > > > >   }
> > > > >   EXPORT_SYMBOL(drm_match_cea_mode);
> > > > > -static bool drm_valid_cea_vic(u8 vic)
> > > > > -{
> > > > > -	return vic > 0 && vic < ARRAY_SIZE(edid_cea_modes);
> > > > > -}
> > > > > -
> > > > >   /**
> > > > >    * drm_get_cea_aspect_ratio - get the picture aspect ratio corresponding to
> > > > >    * the input VIC from the CEA mode list
> > > > > @@ -3117,6 +3492,9 @@ static bool drm_valid_cea_vic(u8 vic)
> > > > >    */
> > > > >   enum hdmi_picture_aspect drm_get_cea_aspect_ratio(const u8 video_code)
> > > > >   {
> > > > > +	if (!drm_valid_cea_vic(video_code))
> > > > > +		return HDMI_PICTURE_ASPECT_NONE;
> > > > > +
> > > > >   	return edid_cea_modes[video_code].picture_aspect_ratio;
> > > > >   }
> > > > >   EXPORT_SYMBOL(drm_get_cea_aspect_ratio);
> > > > > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > > > > index 681cb590f952..0a90efa0246e 100644
> > > > > --- a/include/drm/drm_connector.h
> > > > > +++ b/include/drm/drm_connector.h
> > > > > @@ -188,19 +188,19 @@ struct drm_hdmi_info {
> > > > >   	/**
> > > > >   	 * @y420_vdb_modes: bitmap of modes which can support ycbcr420
> > > > > -	 * output only (not normal RGB/YCBCR444/422 outputs). There are total
> > > > > -	 * 107 VICs defined by CEA-861-F spec, so the size is 128 bits to map
> > > > > -	 * upto 128 VICs;
> > > > > +	 * output only (not normal RGB/YCBCR444/422 outputs). The max VIC
> > > > > +	 * defined by the CEA-861-G spec is 219, so the size is 256 bits to map
> > > > > +	 * upto 256 VICs.
> > > > >   	 */
> > > > > -	unsigned long y420_vdb_modes[BITS_TO_LONGS(128)];
> > > > > +	unsigned long y420_vdb_modes[BITS_TO_LONGS(256)];
> > > > >   	/**
> > > > >   	 * @y420_cmdb_modes: bitmap of modes which can support ycbcr420
> > > > > -	 * output also, along with normal HDMI outputs. There are total 107
> > > > > -	 * VICs defined by CEA-861-F spec, so the size is 128 bits to map upto
> > > > > -	 * 128 VICs;
> > > > > +	 * output also, along with normal HDMI outputs. The max VIC defined by
> > > > > +	 * the CEA-861-G spec is 219, so the size is 256 bits to map upto 256
> > > > > +	 * VICs.
> > > > >   	 */
> > > > > -	unsigned long y420_cmdb_modes[BITS_TO_LONGS(128)];
> > > > > +	unsigned long y420_cmdb_modes[BITS_TO_LONGS(256)];
> > > > >   	/** @y420_cmdb_map: bitmap of SVD index, to extraxt vcb modes */
> > > > >   	u64 y420_cmdb_map;
> > > > > 
> 
> -- 
> Ville Syrjälä
> Intel
