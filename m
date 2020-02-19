Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31DD7163E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 09:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSIAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 03:00:31 -0500
Received: from [167.172.186.51] ([167.172.186.51]:35400 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbgBSIAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:00:30 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 96D5ADFF72;
        Wed, 19 Feb 2020 08:00:44 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NqObR5fTh2vU; Wed, 19 Feb 2020 08:00:43 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 57A49DFFFE;
        Wed, 19 Feb 2020 08:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W0H363Ho9qwE; Wed, 19 Feb 2020 08:00:43 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DD54EDFCA2;
        Wed, 19 Feb 2020 08:00:42 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] irqchip/mmp: A pair of robustness fixed
Date:   Wed, 19 Feb 2020 09:00:22 +0100
Message-Id: <20200219080024.4002-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying these two patches. Thery are not strictly
necessary, but improve diagnostics in case the DT is faulty.

Thanks,
Lubo


