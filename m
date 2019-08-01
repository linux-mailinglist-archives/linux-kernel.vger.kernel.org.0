Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C5C7DA1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 13:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfHALSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 07:18:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfHALSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/xlyNhAtc2Sq5DmhJOAsATTCI6HaFbrRMVkJiBS73ZE=; b=G/mtesQsUwbbK168p9xV8/ak9
        OQk2LOgWkx6nMvve5fEiVBpqohqLeNE67dWqmuwpQjl+xiuf/Tyef7NF7q0+0CGc20egUKg9Lu/G8
        TkfYOxh3G1SZ6+f6ZtCKtFDqD1IHbCcYQl9E1G8/egnaZ4eeXsHK38cwYH1H5aCRyf9Ybt5PJ/4ua
        hF1sIU+sGbwbgoMnC07E0iDLS0/OFOKdr99gm3uksr/fGEdnOGLlFTczlsA2T+Dl/7exXmpG5ORva
        HnxpKYVcIMiHZy2OAuZlIosIzZpYzpRryzrOSsr17oezN4YdXyq2voNRgEFc/JRKTc54q1ytUGaVt
        U3jjFZRzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ht966-0006Uf-Iq; Thu, 01 Aug 2019 11:18:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 78B0E2029F869; Thu,  1 Aug 2019 13:18:12 +0200 (CEST)
Message-Id: <20190801111348.530242235@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 01 Aug 2019 13:13:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 0/5] Fix FIFO-99 abuse
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a bunch of kthreads defaulted to FIFO-99, fix them.

The generic default is FIFO-50, the admin will have to configure the system
anyway.

For some the purpose is to be above OTHER and then FIFO-1 really is sufficient.

