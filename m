Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97B2199C28
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 18:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbgCaQxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 12:53:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgCaQxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M1mhR07HOZla69RsrkO44Gxk+Z9xDcXnvMT8lsqIgFA=; b=adQNgq7gEiRGU9IPa56cqgpMB6
        htVSrYehe9zCxoqLcibx9qSYcQeyX7LGk7oneigtNMVkZRdAEB4JgYFDAHnqysNFblGTPrQQYCf9y
        UYF8C02ttlNL4GRSXpIr5VPThvuvxNXVD350fdIXI/64Vn1igeiyrenN/MRMQrcOPX/88Lrxi8jaG
        QfkVig+Kpriw5UlmZnmaJC39Xos73ELVcNiF3AhmC12UNUUDUcl1kVTLx/jnGuvvhCrWLyRkoLhK9
        KO2w/QwkXXTUzM4E9/O+KO/LHs3SSrnZuCK20PSydgACQ5F9kcN6SRLP+dO0Nav8ZyVQn907k4P4P
        sk1IthpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJK8a-0006NO-4E; Tue, 31 Mar 2020 16:53:16 +0000
Date:   Tue, 31 Mar 2020 09:53:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mporter@kernel.crashing.org, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, alistair@popple.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/44x: Make AKEBONO depends on NET
Message-ID: <20200331165316.GA6380@infradead.org>
References: <20200330143153.32800-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330143153.32800-1-yuehaibing@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why would a board select a network driver?  That is what defconfig
files are for!  I thin kthe select should just go away.
