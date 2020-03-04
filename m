Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D45178931
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 04:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbgCDDdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 22:33:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387535AbgCDDdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M+dQULEmEUvZ5aWDmJahkgl/f7eC2PLINBXVNSLE+f8=; b=QYrRwdIo5LlcWwp3LG53vFwDFJ
        oU6aF5TklVYfocgjVxpAejUO2nFXbqpSKRFQLG+NhkBulVZk/22dbw2gPu1GpM4nrz9TUbUkV+S9s
        LsGWt5IHKKSkHuKOfMs4EqTd6vZIdqXPyILE+CHIW0WARhD5yt1S0UyI0GkY6fK8lSRAY9LEXQ0Jj
        7QE8JeFc9/jBOgNbuWJKY1hh3Wwh429WjpQYxUOhcNUahImF7uhrTR/OqhZvyLi70/b2EgRSKc1ni
        WXDb1JJPkhoG/9dc5eEycJhCbaQkmM7DojVdXgsB96goVMNhCZSYf1ru2FMJOy+Wwjtxw0x5WxOP3
        Qc5CVP/A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9Kmn-0003Si-Mh; Wed, 04 Mar 2020 03:33:29 +0000
Date:   Tue, 3 Mar 2020 19:33:29 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     paulmck@kernel.org, elver@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
Message-ID: <20200304033329.GZ29971@bombadil.infradead.org>
References: <20200304031551.1326-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304031551.1326-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 10:15:51PM -0500, Qian Cai wrote:
> Functions like xas_find_marked(), xas_set_mark(), and xas_clear_mark()
> could happen concurrently result in data races, but those operate only
> on a single bit that are pretty much harmless. For example,

Those aren't data races.  The writes are protected by a spinlock and the
reads by the RCU read lock.  If the tool can't handle RCU protection,
it's not going to be much use.

