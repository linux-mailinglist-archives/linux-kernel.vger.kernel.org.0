Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA68E1684CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 18:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgBURWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 12:22:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25307 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725957AbgBURWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582305741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PrT92zHaWgTBJ1Kuw41BmpBEjKpc8THi+iu6uHyj8E0=;
        b=TmlJvqqQsqOoZ6UNt+tKOIWCMTUTpf46gGNKT13KbiwT5tdNmESaxg1Vp+MCXsSCenOuau
        Rc53eoa+iawfxmJMCpEuNP6Iq6mfs2tm4EddRJfyIGbSv6PO14FxQ99mnvRg1ojoowYNE2
        wMPJHZB7vz2cJh4XTmt9sTa/qfTg758=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-6BzhiZVHOliln9rVNycgzw-1; Fri, 21 Feb 2020 12:22:14 -0500
X-MC-Unique: 6BzhiZVHOliln9rVNycgzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7866107B270;
        Fri, 21 Feb 2020 17:22:12 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-191.ams2.redhat.com [10.36.116.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3DC55D9E2;
        Fri, 21 Feb 2020 17:22:10 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 0/1] drm: Add DRM_MODE_TYPE_USERDEF flag to probed modes
Date:   Fri, 21 Feb 2020 18:22:08 +0100
Message-Id: <20200221172209.509686-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm resending this patch since the discussion on it has fallen
silent for a while now.

Last time I posted it, the discussion seemed to be heading towards
agreement that this is the right thing to do, but I never got an
ack or some such.

See here for the discussion from last time:
https://patchwork.freedesktop.org/patch/340140/

Regards,

Hans


