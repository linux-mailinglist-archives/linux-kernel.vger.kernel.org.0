Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1829D5E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfJNJGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 05:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbfJNJGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:06:43 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B252207FF;
        Mon, 14 Oct 2019 09:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571044002;
        bh=e7F90pxnyT5ltvlpZKfXmZUjRp0991pAScW78vScOz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzh7Wf/4Bplayx6FIAkey/Zc5pSy3dtTuAWmCc2wN4ZFXqktgBe52w7247a3Qk85u
         QxI1eHDPKS4po7PVlmUR15B5tki9RWlyWL1i4wZxZtTagzKWpruWzD6POEes/KuNS5
         W9U/qNLRwqH0qUHjiEkufZMVvjx6/vTNrZcSmFjM=
Date:   Mon, 14 Oct 2019 17:06:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, adam.ford@logicpd.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6q-logicpd: Re-Enable SNVS power key
Message-ID: <20191014090626.GJ12262@dragon>
References: <20191002002029.19189-1-aford173@gmail.com>
 <20191002002029.19189-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002002029.19189-2-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 07:20:29PM -0500, Adam Ford wrote:
> A previous patch disabled the SNVS power key by default which
> breaks the ability for the imx6q-logicpd board to wake from sleep.
> This patch re-enables this feature for this board.
> 
> Fixes: 770856f0da5d ("ARM: dts: imx6qdl: Enable SNVS power key according to board design")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
