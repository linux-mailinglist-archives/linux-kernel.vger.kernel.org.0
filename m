Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F663CF0D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 16:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391380AbfFKOlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 10:41:11 -0400
Received: from orion1388.startdedicated.com ([85.25.199.78]:57318 "EHLO
        mail.everdot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388535AbfFKOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:41:11 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 10:41:10 EDT
Received: from taeyeon.everdot.org (unknown [IPv6:2001:2002:51ed:cee0:5a2:c16b:994e:fb28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: oyvinds)
        by mail.everdot.org (Postfix) with ESMTPSA id 5FF71109050FE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 15:31:44 +0100 (BST)
Date:   Tue, 11 Jun 2019 16:31:42 +0200
From:   =?UTF-8?B?w5Z5dmluZA==?= Saether <oyvinds@linuxreviews.org>
To:     linux-kernel@vger.kernel.org
Subject: Why "must" we upgrade the kernels? A hint would be nice
Message-ID: <20190611163142.1f7c8146@taeyeon.everdot.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the recently released kernels have had a "All users of the
_branch_ kernel series must upgrade." notice. It would be informative
to have some indication as to why users "must" upgrade. The logs are
long and do not really say if there is some urgent reason to upgrade.

Also, as I point out in my latest article about them kernels at
https://linuxreviews.org/Mihan - it is fair to wonder if Greg just put
that warning in a template and forgot about it since it appears to be
attached to every single kernel-release. A warning like that gets less
urgent each time it appears.
