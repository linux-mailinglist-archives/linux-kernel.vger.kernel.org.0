Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C4A96C23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 00:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfHTWY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 18:24:57 -0400
Received: from verein.lst.de ([213.95.11.211]:60424 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730330AbfHTWY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:24:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 812CD68B20; Wed, 21 Aug 2019 00:24:54 +0200 (CEST)
Date:   Wed, 21 Aug 2019 00:24:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        hch@lst.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 04/12] powerpc/mm: drop function __ioremap()
Message-ID: <20190820222454.GB18433@lst.de>
References: <cover.1566309262.git.christophe.leroy@c-s.fr> <ccc439f481a0884e00a6be1bab44bab2a4477fea.1566309262.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccc439f481a0884e00a6be1bab44bab2a4477fea.1566309262.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 02:07:12PM +0000, Christophe Leroy wrote:
> __ioremap() is not used anymore, drop it.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Looks good, I've already dropped my version of this from the generic
ioremap series:

Reviewed-by: Christoph Hellwig <hch@lst.de>
