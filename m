Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E27FE1C29
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391837AbfJWNSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 09:18:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:7044 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389425AbfJWNSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:18:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 06:18:12 -0700
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="191826942"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 06:18:09 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        "open list\:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/virtio: print a single line with device features
In-Reply-To: <20191022090533.GB11828@phenom.ffwll.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191018113832.5460-1-kraxel@redhat.com> <20191022090533.GB11828@phenom.ffwll.local>
Date:   Wed, 23 Oct 2019 16:18:06 +0300
Message-ID: <87mudreh2p.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Fri, Oct 18, 2019 at 01:38:32PM +0200, Gerd Hoffmann wrote:
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_kms.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
>> index 0b3cdb0d83b0..2f5773e43557 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
>> @@ -155,16 +155,15 @@ int virtio_gpu_init(struct drm_device *dev)
>>  #ifdef __LITTLE_ENDIAN
>>  	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
>>  		vgdev->has_virgl_3d = true;
>> -	DRM_INFO("virgl 3d acceleration %s\n",
>> -		 vgdev->has_virgl_3d ? "enabled" : "not supported by host");
>> -#else
>> -	DRM_INFO("virgl 3d acceleration not supported by guest\n");
>>  #endif
>>  	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
>>  		vgdev->has_edid = true;
>> -		DRM_INFO("EDID support available.\n");
>>  	}
>>  
>> +	DRM_INFO("features: %cvirgl %cedid\n",
>> +		 vgdev->has_virgl_3d ? '+' : '-',
>> +		 vgdev->has_edid     ? '+' : '-');
>
> Maybe we should move the various yesno/onoff/enableddisabled helpers from
> i915_utils.h to drm_utils.h and use them more widely?

I'm trying to take it one step further by adding them to
include/linux/string-choice.h [1]. Maybe, uh, fourth time's the charm?

BR,
Jani.

[1] http://lore.kernel.org/r/20191023131308.9420-1-jani.nikula@intel.com


-- 
Jani Nikula, Intel Open Source Graphics Center
