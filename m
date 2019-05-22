Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAF725EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 09:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfEVHfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 03:35:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42433 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfEVHfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:35:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id j53so1175421qta.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=45UZxQiFbq2zrCxPgxX4tICqpmAKAWmhy8nY0NTFEHI=;
        b=UNYACKTHiF2cYn+NOm3CyXNCAsEEv1AIX+KDY8LRZUWz/URwVwlKoybJmvdmtME84f
         6NhOUFhZb+dePnAkmj6LbcTgwXuiKcEoEv1rw9V9kAiabavoRf80T6z1EY+X+uY7bRIo
         FuMb+VPhqloGLQm1ndJUZHxCx3iFfXd7BHocSorcRNmbsYR916AR/ozmVUzieAzyfitq
         swEeWkhVlS8jX3wuHSXCI9Yk+eQOaZO2GONEzUUTegVbNlrrjpAVA/IIyr2OjTfi27xs
         WI+xDNdohXx/pwvcqfn3B/EzqJqYunxbnBhhXX94486bryKjVRNVQU0AZiIg4dvPezZ1
         KoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=45UZxQiFbq2zrCxPgxX4tICqpmAKAWmhy8nY0NTFEHI=;
        b=osbceOYYFk1pYe2IMxqMBpdRGC55izZAv5DAULXkkenr+Aqvz9b/uWZyKjwh4m0iNA
         u0LYugIK2jAjdVayYU3JDaB6wjdrXnA8lr/1BfuYHL0oK4y0hFH3FF/U1GO4X4JfKTe1
         7FCkUsoyz7/zBFTxjzCV2U6cIdAtsLLHz9iKh11D/SIk/YcFZFQb8m4FJSEdoonYcFAl
         6loLweOPripiBVTDm35Ev4qL8ozvUh+0MsUfleC1RMJLAGXPufqm9HT3sfzew+m6hLjt
         IFtFcITuDKOQ5F0fQnhcJCxybTt4n4dc0MaAGoCapGS47xBqfsjTR6M6N4X5wkJfRTNo
         hEhQ==
X-Gm-Message-State: APjAAAUwi9N2Lt8zLwxVhQ9Go6wCHDbwVofRYiWmDoOegi1Lz+fUsRBf
        yiWSWUNc/D0OLXpOot6bVyIh2dF1HlzH40HQrqU=
X-Google-Smtp-Source: APXvYqw+fM3YzGl9hjW4q7BWTPnNwgw1c8e0gg5J0T+WAAq1zXsSJX6oBpyp4QSiUZDF59CDuE07RYp5WiHbdXLYa/Q=
X-Received: by 2002:a0c:aecd:: with SMTP id n13mr61816818qvd.182.1558510523680;
 Wed, 22 May 2019 00:35:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: ste1959bury@gmail.com
Received: by 2002:aed:3ba3:0:0:0:0:0 with HTTP; Wed, 22 May 2019 00:35:23
 -0700 (PDT)
From:   Steven Utonbury <stev1959bury@gmail.com>
Date:   Wed, 22 May 2019 00:35:23 -0700
X-Google-Sender-Auth: LG_w-STXhUp4pjKOeZimph6kniQ
Message-ID: <CAFd1H1-e4qbR_1H3kz3m05QBpgxmDBvBj2jqoo74BsZg2KZb+w@mail.gmail.com>
Subject: =?UTF-8?B?16nXnNeV150=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16nXnNeV150sDQoNCtee16bXpNeUINec16nXnteV16Ig157XnteaINei15wg15TXk9eV15Ai15wg
16nXnNeX16rXmSDXnNeaINen15XXk9edINec15vXnyDXnNeS15HXmSDXlNeU16TXp9eT15Qg16nX
oNei16nXlSDXkdeR16DXpyDXm9eQ158NCtei15wg15nXk9eZINeU15zXp9eV15cg16nXnNeZINee
15DXldeX16gsINeQ16DXmSDXpteo15nXmiDXnNeq16og15zXmiDXkNeqINeU157XmdeT16Ig16LX
nCDXkNeZ15og15zXlNep15nXkiDXnteY16jXlCDXlteVLg0K15DXoNeQINeg16HXlCDXnNeX15bX
ldeoINeQ15zXmS4NCg0K15HXkdeo15vXlA0K16HXmNeZ15HXnw0K
