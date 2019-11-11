Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC18BF81EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 22:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKKVPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 16:15:09 -0500
Received: from verein.lst.de ([213.95.11.211]:52083 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKVPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:15:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 58C6368B05; Mon, 11 Nov 2019 22:15:04 +0100 (CET)
Date:   Mon, 11 Nov 2019 22:15:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-nvme@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH RFC] PCI: endpoint: Add NVMe endpoint function driver
Message-ID: <20191111211503.GA26588@lst.de>
References: <1573493889-22336-1-git-send-email-alan.mikhak@sifive.com> <20191111203743.GA25876@lst.de> <CABEDWGyMrDnuR+AzazHqpiHC9NrHFoVcW5iFREOey04Hv7xLqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABEDWGyMrDnuR+AzazHqpiHC9NrHFoVcW5iFREOey04Hv7xLqw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 01:09:17PM -0800, Alan Mikhak wrote:
> Thanks Christoph. Let me repeat what I think your comment is saying to me.
> You prefer all parsing for nvme command received from host over PCIe
> to be removed from nvme function driver and added to existing fabrics
> command parsing in nvme target code with new flags introduced to
> indicate fabrics vs. PCIe.

At least for all the common commands, yes.  For Create / Delete SQ/CQ
I am not entirely sure how to best implement them yet as there are
valid arguments for keeping it entirely in the PCIe frontend or for
having them in common code, and we'll need to figure out which weight
more heavily.

> Any more thoughts?

I'd love to eventually find time to play with this code.  Do you run
it on unrelease SiFive hard cores, or is there a bitstream for a common
FPGA platform available?-
