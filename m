Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76EFE137ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 02:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgAKBHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 20:07:40 -0500
Received: from [167.172.186.51] ([167.172.186.51]:42330 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727846AbgAKBHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 20:07:40 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F28A7DFCD9;
        Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id C6196-rcrfaJ; Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 329BBDFDFB;
        Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EQCQNUOGurJh; Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id BCBC2DFCD9;
        Sat, 11 Jan 2020 01:07:44 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/3] drm/armada: make it work on MMP2 and MMP3
Date:   Sat, 11 Jan 2020 02:07:31 +0100
Message-Id: <20200111010734.286836-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

chained to this message are patches that are necessary to make the
Armada DRM driver useful on MMP2 and MMP3. They apply on top of
drm-armada-devel.

The first two patches were previously sent separately, around a year ago
or so. The v2 of the third one previosly only implemented only MMP2
support.

Thanks,
Lubo


