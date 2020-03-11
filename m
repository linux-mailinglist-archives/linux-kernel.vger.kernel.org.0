Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925CF182429
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 22:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgCKVqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 17:46:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39121 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729333AbgCKVqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583963167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SRdctigd6e80qWiGHdHq7gT6zmGfN3m4G6aT/B1EkMc=;
        b=WGMkNFHvCV55qwQ4KIFqSg2E/l6NyXxPC1OfJFI3aMzGACPn8E5hzDONUZNVYdnCqIkwnV
        7rYbP4qOvQjht+RfDDz3rUmy/gj3moXLJ2aq6d/dEXQiLZqRJfl0Xb5mM77VfZ7OH3dllr
        owm8vZ4PU3X7/jdEXQo0m+Moyi7G+4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-FdI3Bw1IM4qwqumkyNif3g-1; Wed, 11 Mar 2020 17:46:05 -0400
X-MC-Unique: FdI3Bw1IM4qwqumkyNif3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A7E0801E66;
        Wed, 11 Mar 2020 21:46:04 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBA2491D63;
        Wed, 11 Mar 2020 21:46:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] x86/purgatory: Make sure we fail the build if purgatory.ro has missing symbols
Date:   Wed, 11 Mar 2020 22:45:59 +0100
Message-Id: <20200311214601.18141-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is a new version of my patch (now patch-series) to fix $subject.

The actual patch making the build fail on missing symbols is unchanged,
new in v4 is a preparation patch which fixes a missing symbol (and thus
after the second patch a build failure) when CONFIG_TRACE_BRANCH_PROFILIN=
G
is enabled.

Regards,

Hans

