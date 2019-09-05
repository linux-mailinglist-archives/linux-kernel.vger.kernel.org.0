Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 211A2AA5BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbfIEO1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 10:27:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36653 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbfIEO1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:27:02 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i5six-0007P5-3B; Thu, 05 Sep 2019 16:26:59 +0200
Message-ID: <1567693618.3958.4.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/2] reset: meson-audio-arb: add sm1 support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Sep 2019 16:26:58 +0200
In-Reply-To: <20190905135040.6635-1-jbrunet@baylibre.com>
References: <20190905135040.6635-1-jbrunet@baylibre.com>
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

Hi Jerome,

On Thu, 2019-09-05 at 15:50 +0200, Jerome Brunet wrote:
> This patchset adds the new arb reset lines for the sm1 SoC family
> It has been tested on the sei610 platform.
> 
> Changes since v1 [0]:
> * Fix the mistake on the number of reset as reported by Phililpp (thx)
> 
> [0]:  https://lkml.kernel.org/r/20190820094625.13455-1-jbrunet@baylibre.com
> 
> Jerome Brunet (2):
>   reset: dt-bindings: meson: update arb bindings for sm1
>   reset: meson-audio-arb: add sm1 support
> 
>  .../reset/amlogic,meson-axg-audio-arb.txt     |  3 +-
>  drivers/reset/reset-meson-audio-arb.c         | 43 +++++++++++++++++--
>  .../reset/amlogic,meson-axg-audio-arb.h       |  2 +
>  3 files changed, 44 insertions(+), 4 deletions(-)

Thank you, both applied to reset/next.

regards
Philipp
