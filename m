Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DF5DC9F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393369AbfJRPzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 11:55:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJRPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rz5UQILXn7pea3r9p2TDb1W76FhMtiR//aY0Ef16jhk=; b=J5whKI7G2MlahAXgRqzWwaRKY
        zm1ceDKXVReAhFxefLzpohFLtVI0CNn5xV7Ffzccj7tvs20LjWvTDAtKSPOmrwKF8yWDB0Nu3PZGp
        tGjXu4SFwc26BY0dghvRH+sAI4hzkRDt/ijwM7NI5iX3hdOtMJ1jbDvxNILaMhSyaEShxqfOKriOU
        ZWAYu7GHMatAuvQcnkN8a69s0/AQrVcH40Di3mfFTqt7c7eRBfWmiJk+SoS+1HZ69UMFt9DtEZ4IA
        YRYXa3aJZ1RiItufU946tJ88gdAi16ZC93mruotCWw6gVEO7sbargwUd7dlyC4namxMX7iRXtQ7FY
        2X9DzrGFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLUbU-0006R3-9p; Fri, 18 Oct 2019 15:55:48 +0000
Date:   Fri, 18 Oct 2019 08:55:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] riscv: add missing header file includes
Message-ID: <20191018155548.GD25386@infradead.org>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
 <20191018080841.26712-7-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018080841.26712-7-paul.walmsley@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
