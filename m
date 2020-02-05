Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7C1536DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 18:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgBERkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 12:40:40 -0500
Received: from ms.lwn.net ([45.79.88.28]:52698 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgBERkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:40:40 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 016206E5;
        Wed,  5 Feb 2020 17:40:39 +0000 (UTC)
Date:   Wed, 5 Feb 2020 10:40:38 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow git builds of Sphinx
Message-ID: <20200205104038.7b27a94f@lwn.net>
In-Reply-To: <20200124183316.1719218-1-steve@sk2.org>
References: <20200124183316.1719218-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 19:33:16 +0100
Stephen Kitt <steve@sk2.org> wrote:

> When using a non-release version of Sphinx, from a local build (with
> improvements for kernel doc handling, why not),
> 
> 	sphinx-build --version
> 
> reports versions of the form
> 
> 	sphinx-build 3.0.0+/4703d9119972
> 
> i.e. base version, a plus symbol, slash, and the start of the git hash
> of whatever repository the command is run in (no, not the hash that
> was used to build Sphinx!).
> 
> This patch fixes the installation check in sphinx-pre-install to
> recognise such version output.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Seems useful.  Applied, thanks.

jon
