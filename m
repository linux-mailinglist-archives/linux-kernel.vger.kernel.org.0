Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C333CCADCD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 20:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfJCSDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 14:03:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36405 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731635AbfJCSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:03:19 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1iG5Rb-000388-4I; Thu, 03 Oct 2019 20:03:15 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <pza@pengutronix.de>)
        id 1iG5RX-0006fI-4j; Thu, 03 Oct 2019 20:03:11 +0200
Date:   Thu, 3 Oct 2019 20:03:11 +0200
From:   Philipp Zabel <pza@pengutronix.de>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] reset: meson-audio-arb: add sm1 support
Message-ID: <20191003180311.hlv7s32twzcaxj3x@pengutronix.de>
References: <20190905135040.6635-1-jbrunet@baylibre.com>
 <1567693618.3958.4.camel@pengutronix.de>
 <1jk19oregr.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jk19oregr.fsf@starbuckisacylon.baylibre.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 20:00:35 up 88 days, 10 min, 55 users,  load average: 0.43, 0.19,
 0.15
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Oct 01, 2019 at 11:40:20AM +0200, Jerome Brunet wrote:
[...]
> Looks like this patchset missed v5.4-rc1.
> Could you provide a tag with the bindings to Kevin so we can use the IDs
> in DT until the next merge window ?

Does

  git://git.pengutronix.de/git/pza/linux.git reset/meson-sm1-bindings

work for you?

regards
Philipp
