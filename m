Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBEF18DBFF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 00:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCTXbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 19:31:21 -0400
Received: from ms.lwn.net ([45.79.88.28]:44176 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTXbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:31:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 32E882D6;
        Fri, 20 Mar 2020 23:31:20 +0000 (UTC)
Date:   Fri, 20 Mar 2020 17:31:19 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Perches <joe@perches.com>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coding-style.rst: Add fallthrough as an emacs keyword
Message-ID: <20200320173119.2707c083@lwn.net>
In-Reply-To: <7a2977ea9baacd1580ff80689f2c8f20d45b069d.camel@perches.com>
References: <7a2977ea9baacd1580ff80689f2c8f20d45b069d.camel@perches.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Mar 2020 14:13:59 -0700
Joe Perches <joe@perches.com> wrote:

> fallthrough was added as a pseudo-keyword by commit 294f69e662d1
> ("compiler_attributes.h: Add 'fallthrough' pseudo keyword for switch/case use")
> 
> Add fallthrough as a keyword to the example .emacs content
> so emacs can colorize or highlight the uses.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> I've no idea how to remove the infinite monkeys jibe from the chinese translation

Removing the "jibe" is a second change for this patch, and one which is
not reflected in the changelog.  If we want to sanitize the docs that's
something we can talk about, but I don't want to sneak such changes in.

Please split the patch and make sure the appropriate people are copied on
that change.

Thanks,

jon
