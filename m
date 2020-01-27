Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D090914AB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 22:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA0V0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 16:26:44 -0500
Received: from ms.lwn.net ([45.79.88.28]:36098 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgA0V0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 16:26:43 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BF0ED7DF;
        Mon, 27 Jan 2020 21:26:42 +0000 (UTC)
Date:   Mon, 27 Jan 2020 14:26:41 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/find-unused-docs: Fix massive false positives
Message-ID: <20200127142641.6e865467@lwn.net>
In-Reply-To: <20200127093107.26401-1-geert+renesas@glider.be>
References: <20200127093107.26401-1-geert+renesas@glider.be>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 10:31:07 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> scripts/find-unused-docs.sh invokes scripts/kernel-doc to find out if a
> source file contains kerneldoc or not.
> 
> However, as it passes the no longer supported "-text" option to
> scripts/kernel-doc, the latter prints out its help text, causing all
> files to be considered containing kerneldoc.
> 
> Get rid of these false positives by removing the no longer supported
> "-text" option from the scripts/kernel-doc invocation.
> 
> Fixes: b05142675310d2ac ("scripts: kernel-doc: get rid of unused output formats")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Sigh, I guess I should have tried that script before telling people to use
it.  Thanks for the fix; I've applied it with a CC: stable tag.

jon
