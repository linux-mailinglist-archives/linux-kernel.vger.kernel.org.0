Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1817696C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 00:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfHTW3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 18:29:00 -0400
Received: from verein.lst.de ([213.95.11.211]:60464 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbfHTW27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:28:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DDC1B68BFE; Wed, 21 Aug 2019 00:28:56 +0200 (CEST)
Date:   Wed, 21 Aug 2019 00:28:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@lst.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 07/12] powerpc/mm: move ioremap_prot() into ioremap.c
Message-ID: <20190820222856.GD18433@lst.de>
References: <cover.1566309262.git.christophe.leroy@c-s.fr> <0b3eb0e0f1490a99fd6c983e166fb8946233f151.1566309262.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b3eb0e0f1490a99fd6c983e166fb8946233f151.1566309262.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 02:07:15PM +0000, Christophe Leroy wrote:
> Both ioremap_prot() are idenfical, move them into ioremap.c

s/idenfical/identical/
