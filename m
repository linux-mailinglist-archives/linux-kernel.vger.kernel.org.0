Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B11A49C2BB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 11:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfHYJpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 05:45:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37995 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfHYJpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 05:45:50 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i1p5n-0004vw-10; Sun, 25 Aug 2019 11:45:47 +0200
Date:   Sun, 25 Aug 2019 11:45:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH V6 0/2] genriq/affinity: Make vectors allocation fair
In-Reply-To: <20190825080212.GA17265@ming.t460p>
Message-ID: <alpine.DEB.2.21.1908251145290.1939@nanos.tec.linutronix.de>
References: <20190819124937.9948-1-ming.lei@redhat.com> <20190825080212.GA17265@ming.t460p>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Aug 2019, Ming Lei wrote:
> On Mon, Aug 19, 2019 at 08:49:35PM +0800, Ming Lei wrote:
> 
> Hi Thomas,
> 
> Gentle ping on the two patches.

In my queue
