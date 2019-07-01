Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D4D4603B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfFNOME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 10:12:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36245 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfFNOME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:12:04 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hbmvz-00021E-3k; Fri, 14 Jun 2019 16:12:03 +0200
Message-ID: <1560521523.18257.3.camel@pengutronix.de>
Subject: Re: [PATCH] gpu: ipu-v3: image-convert: Enable double write
 reduction
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     "open list:DRM DRIVERS FOR FREESCALE IMX" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Jun 2019 16:12:03 +0200
In-Reply-To: <20190614010255.13593-1-slongerbeam@gmail.com>
References: <20190614010255.13593-1-slongerbeam@gmail.com>
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

On Thu, 2019-06-13 at 18:02 -0700, Steve Longerbeam wrote:
> For the write channels with 4:2:0 subsampled YUV formats, avoid chroma
> overdraw by only writing chroma for even lines (skip odd chroma rows).
> This reduces necessary write memory bandwidth by at least 25% (more
> with rotation enabled).
> 
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>

Applied on imx-drm/next, thanks!

regards
Philipp
