Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D848DE03
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 21:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfHNTpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 15:45:13 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:51397 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfHNTpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 15:45:13 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id F3C8C20024;
        Wed, 14 Aug 2019 21:45:09 +0200 (CEST)
Date:   Wed, 14 Aug 2019 21:45:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     John Stultz <john.stultz@linaro.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Subject: Re: [RESEND][PATCH v3 00/26] drm: Kirin driver cleanups to prep for
 Kirin960 support
Message-ID: <20190814194508.GA26866@ravnborg.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=pfM-4riQqBG9FQvt634A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xinliang, Rongrong, Xinwei, Chen

On Wed, Aug 14, 2019 at 06:46:36PM +0000, John Stultz wrote:
> Just wanted to resend this patch set so I didn't have to
> continue carrying it forever to keep the HiKey960 board running.
> 
> This patchset contains one fix (in the front, so its easier to
> eventually backport), and a series of changes from YiPing to
> refactor the kirin drm driver so that it can be used on both
> kirin620 based devices (like the original HiKey board) as well
> as kirin960 based devices (like the HiKey960 board).
> 
> The full kirin960 drm support is still being refactored, but as
> this base kirin rework was getting to be substantial, I wanted
> to send out the first chunk, so that the review burden wasn't
> overwhelming.

As Maintainers can we please get some feedback from one of you.
Just an "OK to commit" would do it.
But preferably an ack or a review on the individual patches.

If the reality is that John is the Maintainer today,
then we should update MAINTAINERS to reflect this.

Thanks!

	Sam
