Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6189F94D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 16:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKLP5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 10:57:02 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33692 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfKLP5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:57:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id 71so14900541qkl.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1IbLopXeOg4pNSDD/hzaOk4V2cDKuDqWmgdqhra/5Yc=;
        b=X036rUhYi/tk6XMuC+TlnWVIoBug5wpseQO90+5c/0HKMi190Gk+PymMdlAv5AaNi0
         b6Pkt4BN49UqD+GpnbdxkywsfntW5OqCu36YcVKJIOG5Nz7X9pzTbqx40orHCa0dUHUB
         ExIZnyafQUc85jPZoIn8ZVb2jcs10Qx9Yx3M+Zn3Z////E3MEgqzG1fsov2QM0z+cONf
         UBTfT3crX+Ue86b4d8SrNN43uoYa/h60J0Q7ukQS8glRnQQSrA/0BoZ9oloWgmTLGhuD
         pfsbaTMIjW8mW+c+C+IZueuXKfB541KH/2YVupzNXgSmRu4VWpLovJ32CwulSRqdwurw
         1rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=1IbLopXeOg4pNSDD/hzaOk4V2cDKuDqWmgdqhra/5Yc=;
        b=i3eM32TItx1JTIRFuVlbDYu/qkrPKQ5vamMjw1SDPTilNHPNzHOWQo94bQaMvznJP7
         6kMqTDfWrCUTS2NnfP/P+XRYPX3TGAGzDBE5d3cMJOwN73DHOFTQtrWYuuuvUNvKxLBU
         fYoSBz3QhXJzO2/ztPkJOmx4N97QsM3PzXj2v5ZthjoodJYag/mXMaARXCr8mfbx5a6I
         Y9QsdPtJ1XPVWzeX/0g1dGmMVAPG3FCHBNKqlf59K2K2b4KreGo0czSTlwDcv3T1KVmy
         IGNIJ4yr/lEJ4NT2cxO1Cz7kV3LE8byj3gPmhhNE3qeJjSy7zhtAxYm2BzwKqKQeZjbL
         9d7w==
X-Gm-Message-State: APjAAAUkLEV/pzReXkX5pO6L7+FALJuQxdv2s9LqwDmydFplhJTG9ITo
        yTIjPX6mMe4RWJ+lyxxnYIqrku97Wnn7jZhjpF8=
X-Google-Smtp-Source: APXvYqwitKcOQRBvqOhHd9wRBN/yXvhrgJ8qjKDopMsxcGlYn26De2Lhx/9mFob7HKaqt6qBv2TJhLJ+m9ldPAhflfs=
X-Received: by 2002:ae9:eb07:: with SMTP id b7mr16017099qkg.104.1573574220769;
 Tue, 12 Nov 2019 07:57:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:ed24:0:0:0:0:0 with HTTP; Tue, 12 Nov 2019 07:56:59
 -0800 (PST)
Reply-To: lexx1759@gmail.com
From:   Lexx Jones <frankkoswells11@gmail.com>
Date:   Tue, 12 Nov 2019 15:56:59 +0000
Message-ID: <CAAe31MkR_barQK4T5X4GWpZgXshLFERbTCjXyVMv9mT+6o54Dg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16nXnNeV150g15nXp9eZ16jXmSwg15bXlSDXlNek16LXnSDXlNep16DXmdeZ15Qg16nXqdec15fX
qteZINec15og15DXqiDXlNeU15XXk9ei15Qg15TXlteVLCDXldeR15vXnCDXlteQ16og15zXkCDX
lNem15zXl9eqDQrXnNei16DXldeqLCDXnteT15XXoj8g157XlCDXlNeR16LXmdeUPw0KDQrXkNeg
15kg157Xl9eb15Qg15zXqteS15XXkdeq15oNCg==
