Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2DB6E3E57
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 23:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfJXViq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 17:38:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26609 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729033AbfJXVio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571953123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nuvkab8RF2K/2jxMGJBU7/8U3bmea6SwcpToLGg7U7w=;
        b=AHWQPI2gQdet+gvZXAZ+UhgWG+2sLYEi1TLrKlQwW5Jdh6QttSrM072Ja/FWsWOKzdrhcP
        xW2bj0RUIn/P9qdkl2PLXgwDjolPe296HP7XCZziyD/eF5mAeV6UyEIKovbL+0JKag3xkt
        KP4yHOBkamCmB+MU0dkE/97tgh3PsJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-2wPVNbsxOViqg-LOahlN3A-1; Thu, 24 Oct 2019 17:38:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B63021005500;
        Thu, 24 Oct 2019 21:38:38 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2693A5C1B5;
        Thu, 24 Oct 2019 21:38:37 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mfd: intel_soc_pmic_crc: Add "cht_crystal_cove_pmic" cell to CHT cells
Date:   Thu, 24 Oct 2019 23:38:27 +0200
Message-Id: <20191024213827.144974-5-hdegoede@redhat.com>
In-Reply-To: <20191024213827.144974-1-hdegoede@redhat.com>
References: <20191024213827.144974-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 2wPVNbsxOViqg-LOahlN3A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a "cht_crystal_cove_pmic" cell to the cells for the Cherry Trail
variant of the Crystal Cove PMIC. Adding this cell enables / hooks-up
the new Cherry Trail Crystal Cove PMIC OpRegion driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/intel_soc_pmic_crc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_=
crc.c
index ab09b8225b76..429efa1f8e55 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -88,6 +88,9 @@ static struct mfd_cell crystal_cove_cht_dev[] =3D {
 =09=09.num_resources =3D ARRAY_SIZE(gpio_resources),
 =09=09.resources =3D gpio_resources,
 =09},
+=09{
+=09=09.name =3D "cht_crystal_cove_pmic",
+=09},
 =09{
 =09=09.name =3D "crystal_cove_pwm",
 =09},
--=20
2.23.0

