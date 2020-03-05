Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC82617B24F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 00:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCEXj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 18:39:29 -0500
Received: from ms.lwn.net ([45.79.88.28]:37516 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgCEXj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 18:39:28 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E54242E4;
        Thu,  5 Mar 2020 23:39:27 +0000 (UTC)
Date:   Thu, 5 Mar 2020 16:39:26 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel, linux-doc@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] doc: code generation style
Message-ID: <20200305163926.7fb01b21@lwn.net>
In-Reply-To: <20200305190253.GA28787@avx2>
References: <20200305190253.GA28787@avx2>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 22:02:53 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> I wonder if it would be useful to have something like this in tree.
> 
> It states trivial things for anyone who looked at disassembly few times
> but still...

If nothing else, it needs an introductory paragraph saying what it's about
and why somebody might want to read it.

In general, I'm really reluctant to add stuff to the coding-style
documents (and that's pretty much what this is) without a pretty strong
feeling that it describes generally accepted practices.  So I'd definitely
want a fair number of acks before taking something like this.

Thanks,

jon
