Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5FC116791
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 08:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfLIHfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 02:35:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfLIHfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AUVlsLdi8fdsPbY65zgNJOz3dj9sUmyYrS3GRJDCmW4=; b=n37WqACQPtP5A0fDZTSgc5Gvc
        53EohRNGke78MiTXAPb5O0jfunE9sLrrhr4kZLFsfiFAoJFBHdv0Vj/SU/7kT/kIeBIcQ0WqjwNuI
        j37s8NiLrL4KSdBaOXglHcoo0EQuV9IOjTS8DbW2F2eciE1qcgqrhlg98ncM+hy9DDWk3M9ma2YRE
        NIDmAdOpCKKv/ZjuTc8lbpJtW61ZhBsYpO4J7xjbEDr2MLLg6frbYz2aelWeBArYglPvR1go0Ussi
        f7rByYXsq0N3U9U8A+6vOvek4sfu99ZVW2as8lDlwVkqlFIv1edpfainE7cOd2vFEGT6QRbQUw3Yd
        87zfoUgLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieDZK-0001GA-8U; Mon, 09 Dec 2019 07:34:58 +0000
Date:   Sun, 8 Dec 2019 23:34:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, aryabinin@virtuozzo.com, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        daniel@iogearbox.net, cai@lca.pw
Subject: Re: [PATCH 1/3] mm: add apply_to_existing_pages helper
Message-ID: <20191209073458.GA3852@infradead.org>
References: <20191205140407.1874-1-dja@axtens.net>
 <20191206163853.cdeb5dc80a8622fb6323a8d2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206163853.cdeb5dc80a8622fb6323a8d2@linux-foundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Or a flags argument with descriptive flags to the existing function?
These magic bool arguments don't scale..
