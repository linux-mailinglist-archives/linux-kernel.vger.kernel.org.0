Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3BCB3E23
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfIPPwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 11:52:53 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:44448 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728108AbfIPPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1568649171;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=5vsv823iDPGFqRA288qUAJ1tOsFdw0E0KGwM0/qQ2Ps=;
        b=BjuKfMTADiwEeMWyIpJEGOUsDVO+rsGwaTH3gqgSOxtgsdvECTqZ3/s3cCfM2LB+
        9k7BvUnLTxAQiKLKaXJuhqBKWNu8xCfgQzHeyQBETbfEXUJXAY9POhufCvxdlRNn44g
        PQau6lgBseHE0pEXOwrqhJg1UafuqcFBpQPGmXpY=
Date:   Mon, 16 Sep 2019 15:52:51 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Pengfei Li <lpf.vector@gmail.com>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com
Subject: Re: [PATCH v5 7/7] mm, slab_common: Modify kmalloc_caches[type][idx]
 to kmalloc_caches[idx][type]
In-Reply-To: <20190916144558.27282-8-lpf.vector@gmail.com>
Message-ID: <0100016d3ac6d132-891c437f-2aeb-41de-84d8-aec48bc20ee4-000000@email.amazonses.com>
References: <20190916144558.27282-1-lpf.vector@gmail.com> <20190916144558.27282-8-lpf.vector@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.09.16-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Pengfei Li wrote:

> KMALLOC_NORMAL is the most frequently accessed, and kmalloc_caches[]
> is initialized by different types of the same size.
>
> So modifying kmalloc_caches[type][idx] to kmalloc_caches[idx][type]
> will benefit performance.


Why would that increase performance? Using your scheme means that the
KMALLOC_NORMAL pointers are spread over more cachelines. Since
KMALLOC_NORMAL is most frequently accessed this would cause
a performance regression.

