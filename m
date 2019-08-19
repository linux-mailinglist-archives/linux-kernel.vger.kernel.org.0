Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A929D94FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 23:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfHSVZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 17:25:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36684 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfHSVZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:25:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so2460324lfp.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=430WKBjW4qP2Uk2l8iZHrKhfwlDm5+osLr0EqzEZAHs=;
        b=fTyfVfIRNralvYNpbpTJpVOy3b8MTJyn/tGZ8zgsjoDpI9oLacF1yHV25JyznzKinc
         Vcwc6hA74L/hwCeSKOOHjCeVmbGIt6HPspQspfzk+0pP5eKghGdOXpEEVpfopUFJ5F4+
         QAQsi8zcls5F+242WxpDQ90oxtMTQRvh5bUvaiAXK2x7OA/Qjyl4WgARMUP04j092hq4
         sEkUTiZxFqq447FRsmTy21N95oStWACPS94VJ5YZIID2UFa4ckq9tL2sNeonNbCCRU+d
         AYPurrr5HvYNdghPSOHOFHGqjyVDGikE8p3+GWXrL34H09oIVyO5XTwKXKxfJMy50Q2/
         /5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=430WKBjW4qP2Uk2l8iZHrKhfwlDm5+osLr0EqzEZAHs=;
        b=bPCDtkkAjvK5wG2lZDg2AuJXjg2bXoskboJzDuo8BS9mJAse1YHCUikEmulHZXiirX
         XUTFvov6b4/C9rEqzU504sgn4LCvRsrup/4emxTs1bO9Yra13BPoHPEnrEwBi8FZF8mM
         stq30ikMNNIxCZ0/u/yqsZcHvs6ZXdY//5HbqpgZiELWVeBcoKqpeUGfS2qJoRq+RPY/
         7YSvHpfsNx/DmFG4UIqUSRptQYq23xecG2nTgB3Vn5pOsThZeyFX2iiMVCkTt3dnMgTE
         dNnvAVY5ARlOIWAeAbzCVtSpQf7Hnfyhr6QEXIrrp9hX7w2YGp4wVhRaO1UClWwPhA5r
         V73A==
X-Gm-Message-State: APjAAAVWAAX9baIftvEzt/RXkrF8GEUBGRS8MxQoQnoqbsO4MYchImCs
        uKf5iLH3eLuZUBnHtDIuoBi4/UiEUVXWogX4ZG4=
X-Google-Smtp-Source: APXvYqy6fNmz7sK+RCug2+HaNwgye40GzxCCU203NebRrdc3DD7MSsXoDtef5t9f8gq01HAzg5bB6h5FAKcdOtjlT9Y=
X-Received: by 2002:a19:6557:: with SMTP id c23mr13179348lfj.12.1566249945151;
 Mon, 19 Aug 2019 14:25:45 -0700 (PDT)
MIME-Version: 1.0
Reply-To: akgazshak@gmail.com
Received: by 2002:a19:4b50:0:0:0:0:0 with HTTP; Mon, 19 Aug 2019 14:25:44
 -0700 (PDT)
From:   =?UTF-8?Q?=C4=B0shak_BURAKGAZI?= <akgazishak@gmail.com>
Date:   Mon, 19 Aug 2019 14:25:44 -0700
X-Google-Sender-Auth: S2dXYxfMrBfMLbgg9R5azsNiQmE
Message-ID: <CAEgzzmj+dGrsNn42Uq6ZQSehxMiiVj5O4Z2xYHBi_wQcJPFFuw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15TXmdeZLA0KDQrXnteX15vXlCDXnNep157XldeiINee15vXnSDXkdeT15XXkCLXnCDXqdep15zX
l9eq15kg15DXnNeZ15vXnSDXp9eV15PXnSDXldeU15TXptei15Qg16nXnNeZINec15LXkdeZINeU
16TXmden15PXldefINeU15bXlA0K15vXkNefINeR15jXldeo16fXmdeULCDXkNeg15Ag16DXodeU
INec15fXlteV16gg15DXnNeZLg0KDQrXkdeR16jXm9eUDQrXkNeZ16nXpw0K
