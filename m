Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9811F70A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 10:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfLOJkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 04:40:22 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:56888 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfLOJkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 04:40:22 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8A4612006F;
        Sun, 15 Dec 2019 10:40:19 +0100 (CET)
Date:   Sun, 15 Dec 2019 10:40:18 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH 3/3] drm/panel: add panel driver for Xinpeng XPP055C272
 panels
Message-ID: <20191215094018.GA27552@ravnborg.org>
References: <20191209144208.4863-1-heiko@sntech.de>
 <2272108.TFxdGdtKl4@diego>
 <20191215082916.GA25772@ravnborg.org>
 <1744285.zQlJhejOUX@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744285.zQlJhejOUX@phil>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=cWZPjuQPZkZKr6VumlEA:9 a=CjuIK1q_8ugA:10 a=pHzHmUro8NiASowvMSCR:22
        a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko.

> > The idea was that if a write returned an error then do not even attempt
> > more writes. So if a write fails we do not loose the original error
> > code, assuming subsequent write would also fail.
> 
> Shouldn't the code above do exactly that? ... Because it's like
> 
> 	ret = dcs_write(...)
> 	if (ret <0)
> 		return ret;
> 
> So if any of the dcs_writes goes wrong it should just return the
> error code from that write from the function and not try any more
> writes. (or I'm blind and do not see something ;-) )

You are right, the code does it already.

	Sam
