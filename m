Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A24620AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfGHOmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 10:42:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbfGHOmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FbVe+96SnHQdB3XrjHSvItUUD9LRS2dN3DEOjB6fZxA=; b=SuZJoN+Qoru93LMevhhWQfOim
        V2QIOqYKMDTCKvDf7k8xEfvTXFkM6TbWL6Nbu8198IgOJ7nRhrTkjJOQXzI0qZhmE8A0bu+PMYl4M
        8qDVIt6fbexi5k9c+Zb2MvIpDiqRWLhvMeP7MmT17s/rDXT8A+XwrI6H3dixLlucPufH6T7wCsQus
        UfrSqqQazKVAw1K5+ggVCoXjhxdKzRda+y8LsXRTt+X4l9HgAXIIsF/FM4+6d1JjmrboRnmiggS9+
        vlcnCwcSjPQBKQ0WLFdq/Dsnk1lRrEIlI/UB46O1KbB0UrMsBIW7PnuD5bzgYmlISbFwZOaxETeVA
        yZaW6tR/g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkUqN-0008FF-1b; Mon, 08 Jul 2019 14:42:15 +0000
Date:   Mon, 8 Jul 2019 07:42:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        will@kernel.org, peterz@infradead.org
Subject: Re: [PATCH] mm: remove redundant assignment of entry
Message-ID: <20190708144214.GD32320@bombadil.infradead.org>
References: <20190708082740.21111-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708082740.21111-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 04:27:40PM +0800, Wei Yang wrote:
> Since ptent will not be changed after previous assignment of entry, it
> is not necessary to do the assignment again.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
