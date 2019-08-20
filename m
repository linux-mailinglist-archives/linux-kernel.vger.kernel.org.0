Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B760964D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfHTPm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 11:42:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45993 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbfHTPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:42:56 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i06HZ-0002QY-82; Tue, 20 Aug 2019 17:42:49 +0200
Message-ID: <1566315769.3030.20.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] Documentation: media: Describe
 V4L2_CID_UNIT_CELL_SIZE
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ricardo Ribalda Delgado <ribalda@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Aug 2019 17:42:49 +0200
In-Reply-To: <20190820094027.4144-2-ribalda@kernel.org>
References: <20190820094027.4144-1-ribalda@kernel.org>
         <20190820094027.4144-2-ribalda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 11:40 +0200, Ricardo Ribalda Delgado wrote:
> New control to pass to userspace the width/height of a pixel. Which is
> needed for calibration and lens selection.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
> ---
>  Documentation/media/uapi/v4l/ext-ctrls-camera.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/media/uapi/v4l/ext-ctrls-camera.rst b/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
> index 51c1d5c9eb00..b43047d4e7a1 100644
> --- a/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
> +++ b/Documentation/media/uapi/v4l/ext-ctrls-camera.rst
> @@ -510,6 +510,14 @@ enum v4l2_scene_mode -
>      value down. A value of zero stops the motion if one is in progress
>      and has no effect otherwise.
>  
> +``V4L2_CID_UNIT_CELL_SIZE (struct)``
> +    This control returns the unit cell size in nanometres. The struct provides
> +    the width and the height in separated fields to take into consideration
> +    asymmetric pixels and/or hardware binning.
> +    The unit cell consist on the whole area of the pixel, sensitive and
> +    non-sensitive.

"consists of", otherwise this looks unambiguous to me.

I'm not sure if it is required to add a table for struct v4l2_area,
similarly to the other compound controls.

> +    This control is required for automatic calibration sensors/cameras.
> +
>  .. [#f1]
>     This control may be changed to a menu control in the future, if more
>     options are required.

regards
Philipp
