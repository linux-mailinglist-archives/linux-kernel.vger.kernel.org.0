Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60DC8107CAE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 04:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKWD6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 22:58:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfKWD63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 22:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ve9o6Q9Fd2C5cJTWIbP8DXDZR7qDvAhzsiyT72pE0c8=; b=ItUkIrIAGLsNCdGmEeYfSqeKL
        HhBJybv41lRbzckoKyA5OBrkVxbPI2HFGFqe+KNOo3DhzEProYP9NLUXdOItCp6hEO1WKoRpXu6Ud
        3RyxNWk5VWsQnJjZDIRXnN91wN1N1n+uy9a8/YVw0TMJMmdouoHqoc3ZO7NYamJR5Wi2pLFjY8s5k
        IGP79FtWGzKU0+cD/cgRy1zS9n93Yyzuiitbt3lJ2oMLHdpkAvshLkJ3bzr1DBr6YZFNqyclczhy0
        tNcCR21yTzbwtIBDGD2Bg/8ihy5gzBHl+I8+gN+oY8l7rfn/MTQjMvbOrRRjZKFAGeo8Nlfqobo6B
        BrK5KKcKw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYMZ2-0003Bw-0b; Sat, 23 Nov 2019 03:58:28 +0000
Date:   Fri, 22 Nov 2019 19:58:27 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krste@berkeley.edu,
        waterman@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: riscv: add patch acceptance guidelines
Message-ID: <20191123035827.GZ20752@bombadil.infradead.org>
References: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 06:44:39PM -0800, Paul Walmsley wrote:
>  Documentation/riscv/patch-acceptance.rst | 32 ++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/riscv/patch-acceptance.rst

Should this be linked into the toctree somewhere so it's findable
on kernel.org?  Maybe add a line to Documentation/process/index.rst
to include ../riscv/patch-acceptance.rst?
