Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8522FAE3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 08:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393486AbfIJGfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 02:35:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbfIJGfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EfnT9VJR0SzXrUiBMWp/FXHqRLpUfRlW0ohjNvj2Vb8=; b=b1gm8I5xilk/JhHQW9MqgCP2G
        z2VJw4VRyInonLf6onQ5j0cmX4L6CXk0HFSBHyJQ3BSiTDU288kmel00mX7AgmiajAGfUpxRoTa/M
        U57jR5+acOxHJWzA5WvGX+t2083sSeCJI1kh/3E/G0IfqE/JSnEubow+5KQZAODwWxxEBbq9lIpWn
        jA3aY/7ZRf29cUM4mYDHyAyPJ3SEE+pbJy1LBPGbfLVHEkuAcANFp9d/8kvenpdi2yvRDtPP8kU9m
        2XDamMgXIGh4sND10NMvRitV58Wx6p1jvcp0okM7/RmX9jmfjkLuFnvfqxzC9RElAh8P0HX8pCVLw
        mcLSvMRoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i7Zk6-0005SP-DO; Tue, 10 Sep 2019 06:35:10 +0000
Date:   Mon, 9 Sep 2019 23:35:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: replace IFF abbreviation  with 'if and only if'
Message-ID: <20190910063510.GA4267@infradead.org>
References: <20190907105116.19183-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907105116.19183-1-federico.vaga@vaga.pv.it>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 12:51:16PM +0200, Federico Vaga wrote:
> In a normal piece of text the use of 'iff' does not guarantee a correct
> interpretation because it is easy to confuse it for a typo (if or iff?).
> 
> I believe that IFF should not be used outside a logical/mathematical
> expression. For this reason with this patch I am replacing 'iff' with
> 'if an only if' in text, and I am leaving it as it is in logical formulae.

Hell no.  If you want to avoid the usage in your own docs please go for
it, but as seen in your patch we commonly use and that is a good thing
as it brings the information across in a very compact way.
