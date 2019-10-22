Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0D4E0D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 22:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfJVUiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 16:38:24 -0400
Received: from ms.lwn.net ([45.79.88.28]:48476 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfJVUiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:38:23 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1F22037B;
        Tue, 22 Oct 2019 20:38:23 +0000 (UTC)
Date:   Tue, 22 Oct 2019 14:38:21 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] docs/core-api: memory-allocation: mention size helpers
Message-ID: <20191022143821.2d20772d@lwn.net>
In-Reply-To: <ed4a98e3d8c0efe58d888cf8fc6e913b40281f11.camel@alliedtelesis.co.nz>
References: <20191021212751.21300-1-chris.packham@alliedtelesis.co.nz>
        <20191022071920.4efff72b@lwn.net>
        <ed4a98e3d8c0efe58d888cf8fc6e913b40281f11.camel@alliedtelesis.co.nz>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 20:05:38 +0000
Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> > Quick comment: we don't need :c:func: anymore; the markup happens anyway.
> > So rather than adding more of them, could I ask you to please take out the
> > ones that are there now?  
> 
> So just with backquotes i.e. :c:func:`kmalloc` becomes `kmalloc`?

No, just:

	kmalloc()

will do the trick.  See:

	https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#the-c-domain

Thanks,

jon
