Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB42A4DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 05:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfIBD3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 23:29:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbfIBD3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:29:37 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46MFv23NDjz9sNF; Mon,  2 Sep 2019 13:29:33 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 136bc0397ae21dbf63ca02e5775ad353a479cd2f
In-Reply-To: <20190820021326.6884-3-bauerman@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Anshuman Khandual <anshuman.linux@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 02/16] powerpc/pseries: Introduce option to build secure virtual machines
Message-Id: <46MFv23NDjz9sNF@ozlabs.org>
Date:   Mon,  2 Sep 2019 13:29:33 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 02:13:12 UTC, Thiago Jung Bauermann wrote:
> Introduce CONFIG_PPC_SVM to control support for secure guests and include
> Ultravisor-related helpers when it is selected
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Patch 2-14 & 16 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/136bc0397ae21dbf63ca02e5775ad353a479cd2f

cheers
