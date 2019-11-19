Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E92A3102E61
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 22:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfKSVoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 16:44:06 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:37880 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbfKSVoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:44:05 -0500
X-IronPort-AV: E=Sophos;i="5.69,219,1571695200"; 
   d="scan'208";a="412575410"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 19 Nov 2019 22:44:04 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kernel-janitors@vger.kernel.org, cocci@systeme.lip6.fr,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>
Subject: [PATCH 0/4 v2] improve platform_get_irq.cocci
Date:   Tue, 19 Nov 2019 22:08:21 +0100
Message-Id: <1574197705-31132-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various cleanups in platform_get_irq.cocci to give more useful
patches and to give a few more results.

v2: fix some interchanged From's and To's
