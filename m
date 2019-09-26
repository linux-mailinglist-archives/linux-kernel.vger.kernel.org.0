Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216DDBED68
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 10:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfIZIaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 04:30:35 -0400
Received: from regular1.263xmail.com ([211.150.70.201]:60558 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbfIZIac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:32 -0400
Received: from localhost (unknown [192.168.167.130])
        by regular1.263xmail.com (Postfix) with ESMTP id DE672393;
        Thu, 26 Sep 2019 16:30:14 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.10.69] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18367T139820068222720S1569486611945312_;
        Thu, 26 Sep 2019 16:30:13 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <cb900f1e39dd0f903650b7b2dd7d8341>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Ayan Kumar Halder <Ayan.Halder@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1569398801-92201-1-git-send-email-hjc@rock-chips.com>
 <1569398801-92201-2-git-send-email-hjc@rock-chips.com>
 <CAKMK7uFn7JqqjQPwuEA=SvoCQ5GxB148ZA3zKSTuj7Gareu7Tw@mail.gmail.com>
From:   "sandy.huang" <hjc@rock-chips.com>
Message-ID: <48b7491e-5e32-bfe6-c9a3-6024f6e50b1a@rock-chips.com>
Date:   Thu, 26 Sep 2019 16:30:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFn7JqqjQPwuEA=SvoCQ5GxB148ZA3zKSTuj7Gareu7Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/9/25 下午7:20, Daniel Vetter 写道:
> On Wed, Sep 25, 2019 at 10:07 AM Sandy Huang <hjc@rock-chips.com> wrote:
>> These new format is supported by some rockchip socs:
>>
>> DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
>> DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
>> DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10
>>
>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> Again, please use the block formats to describe these, plus proper
> comments as Maarten also asked for.
> -Daniel

Hi Daniel and Maarten,

     The new v2 patches have update to block formats, please help to 
review, thanks.

>
>> ---
>>   drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
>>   include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
>> index c630064..f25fa81 100644
>> --- a/drivers/gpu/drm/drm_fourcc.c
>> +++ b/drivers/gpu/drm/drm_fourcc.c
>> @@ -274,6 +274,24 @@ const struct drm_format_info *__drm_format_info(u32 format)
>>                  { .format = DRM_FORMAT_YUV420_10BIT,    .depth = 0,
>>                    .num_planes = 1, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
>>                    .is_yuv = true },
>> +               { .format = DRM_FORMAT_NV12_10,         .depth = 0,
>> +                 .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
>> +                 .is_yuv = true },
>> +               { .format = DRM_FORMAT_NV21_10,         .depth = 0,
>> +                 .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
>> +                 .is_yuv = true },
>> +               { .format = DRM_FORMAT_NV16_10,         .depth = 0,
>> +                 .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 1,
>> +                 .is_yuv = true },
>> +               { .format = DRM_FORMAT_NV61_10,         .depth = 0,
>> +                 .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 1,
>> +                 .is_yuv = true },
>> +               { .format = DRM_FORMAT_NV24_10,         .depth = 0,
>> +                 .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 1, .vsub = 1,
>> +                 .is_yuv = true },
>> +               { .format = DRM_FORMAT_NV42_10,         .depth = 0,
>> +                 .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 1, .vsub = 1,
>> +                 .is_yuv = true },
>>          };
>>
>>          unsigned int i;
>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
>> index 3feeaa3..0479f47 100644
>> --- a/include/uapi/drm/drm_fourcc.h
>> +++ b/include/uapi/drm/drm_fourcc.h
>> @@ -238,6 +238,20 @@ extern "C" {
>>   #define DRM_FORMAT_NV42                fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
>>
>>   /*
>> + * 2 plane YCbCr 10bit
>> + * index 0 = Y plane, [9:0] Y
>> + * index 1 = Cr:Cb plane, [19:0]
>> + * or
>> + * index 1 = Cb:Cr plane, [19:0]
>> + */
>> +#define DRM_FORMAT_NV12_10     fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
>> +#define DRM_FORMAT_NV21_10     fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
>> +#define DRM_FORMAT_NV16_10     fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
>> +#define DRM_FORMAT_NV61_10     fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
>> +#define DRM_FORMAT_NV24_10     fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
>> +#define DRM_FORMAT_NV42_10     fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
>> +
>> +/*
>>    * 2 plane YCbCr MSB aligned
>>    * index 0 = Y plane, [15:0] Y:x [10:6] little endian
>>    * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
>> --
>> 2.7.4
>>
>>
>>
>


