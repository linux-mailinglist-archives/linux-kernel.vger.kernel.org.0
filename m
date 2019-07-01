Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD332D46
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfFCJ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 05:58:54 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50159 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfFCJ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:58:52 -0400
Received: from starbug-2.treewalker.org (unknown [193.22.133.58])
        (Authenticated sender: relay@treewalker.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 69DCF200019;
        Mon,  3 Jun 2019 09:58:43 +0000 (UTC)
Received: from hyperion.localnet (hyperion.local.treewalker.org [192.168.0.43])
        by starbug-2.treewalker.org (Postfix) with ESMTP id 8419F99E971;
        Mon,  3 Jun 2019 11:58:39 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me
Subject: Re: [PATCH 2/2] drm/panel: Add Novatek NT39016 panel support
Date:   Mon, 03 Jun 2019 11:58:39 +0200
Message-ID: <4433088.CzTouAtFss@hyperion>
In-Reply-To: <20190602184453.GB10060@ravnborg.org>
References: <20190602164844.15659-1-paul@crapouillou.net> <20190602164844.15659-2-paul@crapouillou.net> <20190602184453.GB10060@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 2 June 2019 20:44:53 CEST Sam Ravnborg wrote:

> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> This driver is authored by Maarten ter Huurne <maarten@treewalker.org>
> as well as you.
> Could you get a s-o-b or at least some other formal
> attribution of Maarten in the changelog.

This is based on a driver I wrote for the GCW Zero back when we were 
using fbdev. Paul updated it for drm and did additional cleanups.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>

Bye,
		Maarten



