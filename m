Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE9DE184E71
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 19:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCMSQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 14:16:07 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:56240 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgCMSQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:16:07 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 9D2E320039;
        Fri, 13 Mar 2020 19:16:03 +0100 (CET)
Date:   Fri, 13 Mar 2020 19:16:02 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3] drm/bochs: downgrade pci_request_region failure from
 error to warning
Message-ID: <20200313181602.GA16474@ravnborg.org>
References: <20200313084152.2734-1-kraxel@redhat.com>
 <20200313090338.GA31815@ravnborg.org>
 <20200313143530.6aoagldak3kpe3xv@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313143530.6aoagldak3kpe3xv@sirius.home.kraxel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=TKvIToawjpI_eSArduEA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 03:35:30PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > +	if (pci_request_region(pdev, 0, "bochs-drm") != 0)
> > > +		DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
> > So you could use drm_WARN() which is what is preferred these days.
> 
> Nope, this isn't yet in -fixes.
Ups, did not see this was for -fixes.
My ack stands without ths change then.

	Sam
