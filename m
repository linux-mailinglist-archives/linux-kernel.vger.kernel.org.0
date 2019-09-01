Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1302A497F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfIAMuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 08:50:11 -0400
Received: from elvis.franken.de ([193.175.24.41]:50146 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfIAMuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:50:11 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1i4PJ2-0004Kv-00; Sun, 01 Sep 2019 14:50:08 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 62FDCC277F; Sun,  1 Sep 2019 14:49:59 +0200 (CEST)
Date:   Sun, 1 Sep 2019 14:49:59 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] W1 drivers for devices used in SGI systems
Message-ID: <20190901124959.GA4164@alpha.franken.de>
References: <20190831082623.15627-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831082623.15627-1-tbogendoerfer@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 10:26:20AM +0200, Thomas Bogendoerfer wrote:
> These patches add two W1 drivers. One is a driver for the W1 master in
> SGI ASICs, which is used in various machine starting with SGI Origin systems. 
> The other is a W1 slave driver for Dallas/Maxim EPROM devices used
> in the same type of SGI machines.
> [..]

Greg,

I've posted this the first time end of may, asked maintainer about
status, reposted it and so on. So far no feedback from the W1
subsystem maintainer. I have other patchsets needing this changes,
so I'm asking you, if you could take these patches for 5.4 ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
