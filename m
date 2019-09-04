Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A695AA924B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfIDT1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 15:27:20 -0400
Received: from a9-34.smtp-out.amazonses.com ([54.240.9.34]:35370 "EHLO
        a9-34.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729740AbfIDT1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1567625238;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=GSADDDUzucjw0izr9jastymBrpAHNMYRyeaYzA8+Uhc=;
        b=mP+Wb2fqiHE3fKmY0lTJ5cgTL8X56zeovIKhwE5tXL5FGqe/zJl7HMc0vpR0WP9L
        pGZs89DUthfoOijrI+PGaCd/DuxFWZxVZ+1TjeK/CiriyJQ4vP3haOtVCs2yZB7qwNj
        X8T9yx92nvnLJkhMYDzkopTHI5cS8NGvFL9Bs/ck=
Date:   Wed, 4 Sep 2019 19:27:18 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Pengfei Li <lpf.vector@gmail.com>
cc:     akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] mm, slab: Make kmalloc_info[] contain all types of
 names
In-Reply-To: <20190903160430.1368-1-lpf.vector@gmail.com>
Message-ID: <0100016cfdbed786-8e9441ab-4c0c-4d2d-b9dc-d1d6878481b8-000000@email.amazonses.com>
References: <20190903160430.1368-1-lpf.vector@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.09.04-54.240.9.34
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019, Pengfei Li wrote:

> There are three types of kmalloc, KMALLOC_NORMAL, KMALLOC_RECLAIM
> and KMALLOC_DMA.

I only got a few patches of this set. Can I see the complete patchset
somewhere?

