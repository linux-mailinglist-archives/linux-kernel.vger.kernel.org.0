Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6A44BC86
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfFSPJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 11:09:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33021 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfFSPJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:09:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E62230198AA;
        Wed, 19 Jun 2019 15:09:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35D075D9C6;
        Wed, 19 Jun 2019 15:09:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     dhowells@redhat.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18974.1560956941.1@warthog.procyon.org.uk>
Date:   Wed, 19 Jun 2019 16:09:01 +0100
Message-ID: <18975.1560956941@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 19 Jun 2019 15:09:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Could you add my keys-next and afs-next branches to linux-next?  They can be
found here:

git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git#keys-next
git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git#afs-next

Thanks,
David
