Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F323350A31
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 13:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfFXLzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 07:55:01 -0400
Received: from verein.lst.de ([213.95.11.211]:54634 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfFXLzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:55:01 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 647BB68B02; Mon, 24 Jun 2019 13:54:29 +0200 (CEST)
Date:   Mon, 24 Jun 2019 13:54:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: RISC-V nommu support v2
Message-ID: <20190624115428.GA9538@lst.de>
References: <20190624054311.30256-1-hch@lst.de> <28e3d823-7b78-fa2b-5ca7-79f0c62f9ecb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e3d823-7b78-fa2b-5ca7-79f0c62f9ecb@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:47:07PM +0100, Vladimir Murzin wrote:
> Since you are using binfmt_flat which is kind of 32-bit only I was expecting to see
> CONFIG_COMPAT (or something similar to that, like ILP32) enabled, yet I could not
> find it.

There is no such thing in RISC-V.  I don't know of any 64-bit RISC-V
cpu that can actually run 32-bit RISC-V code, although in theory that
is possible.  There also is nothing like the x86 x32 or mips n32 mode
available either for now.

But it turns out that with a few fixes to binfmt_flat it can run 64-bit
binaries just fine.  I sent that series out a while ago, and IIRC you
actually commented on it.
