Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05FDFB218
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 15:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfKMOFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 09:05:38 -0500
Received: from mail.cmpwn.com ([45.56.77.53]:60566 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfKMOFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1573653937; bh=KeEE3s9Ta1SXh5PBJFQvgxmSWvWtxdwlj+LrboYWUxA=;
        h=In-Reply-To:Date:Cc:Subject:From:To;
        b=vlWfTSlQxiCPF86MBegHJFvLo8nfRd+YNWFOcJz6N5N+xF3wfQ2uQRYwGwraZcFSK
         F/ZgDJybs02ac/Jh7TsrQXSBu7Eaxh9b3nZDFUyKW9HxcxQbtvzUgFvIMF//T2GBf6
         SFPrz/JUlDZeXPFtee0t0RP5uy1cTdWQ6eE+iIC8=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20191113005628.GT11244@42.do-not-panic.com>
Date:   Wed, 13 Nov 2019 09:05:33 -0500
Cc:     <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <~sircmpwn/public-inbox@lists.sr.ht>, <robbat2@gentoo.org>
Subject: Re: [PATCH v2] firmware loader: log path to loaded firmwares
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Luis Chamberlain" <mcgrof@kernel.org>
Message-Id: <BYETRH5DWPRO.5M04O9X5SJ6Y@homura>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, no problem. Thanks for clarifying.
