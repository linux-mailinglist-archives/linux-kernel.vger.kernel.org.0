Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876FCA9B6D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 09:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbfIEHOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 03:14:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbfIEHOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:14:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D698A10567;
        Thu,  5 Sep 2019 07:14:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-72.ams2.redhat.com [10.36.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D87B60606;
        Thu,  5 Sep 2019 07:14:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4BA8531E76; Thu,  5 Sep 2019 09:14:07 +0200 (CEST)
Date:   Thu, 5 Sep 2019 09:14:07 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Jaak Ristioja <jaak@ristioja.ee>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: Xorg indefinitely hangs in kernelspace
Message-ID: <20190905071407.47iywqcqomizs3yr@sirius.home.kraxel.org>
References: <92785039-0941-4626-610b-f4e3d9613069@ristioja.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92785039-0941-4626-610b-f4e3d9613069@ristioja.ee>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 05 Sep 2019 07:14:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:00:10PM +0300, Jaak Ristioja wrote:
> Hello!
> 
> I'm writing to report a crash in the QXL / DRM code in the Linux kernel.
> I originally filed the issue on LaunchPad and more details can be found
> there, although I doubt whether these details are useful.

Any change with kernel 5.3-rc7 ?

cheers,
  Gerd

