Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBFF688E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 14:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbfGOM34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 08:29:56 -0400
Received: from verein.lst.de ([213.95.11.211]:60271 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbfGOM34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:29:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CCC8A68B05; Mon, 15 Jul 2019 14:29:53 +0200 (CEST)
Date:   Mon, 15 Jul 2019 14:29:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH] nvme: Add support for Apple 2018+ models
Message-ID: <20190715122953.GB3937@lst.de>
References: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org> <20190715081041.GB31791@lst.de> <c088cb27f99adbcc1f8faf8e86167903f11593b8.camel@kernel.crashing.org> <25c3813ab1c2943658d7e79756803801b14a34db.camel@kernel.crashing.org> <4caeb954b2fa91445e02bac7ac9610ca886b4dd8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4caeb954b2fa91445e02bac7ac9610ca886b4dd8.camel@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 12:28:05PM +0300, Maxim Levitsky wrote:
> 
> To be honest, the spec explicitly states that minimum submission queue entry size is 64 
> and minimum completion entry size should be is 16 bytes for NVM command set:

That doesn't keep Apple from implementing whatever they want and soldering
that down on their MacBook mainboards unfortunately :(
