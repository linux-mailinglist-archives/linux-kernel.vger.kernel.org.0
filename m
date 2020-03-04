Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1331791B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 14:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgCDNt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 08:49:58 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44180 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgCDNt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:49:58 -0500
Received: by mail-io1-f68.google.com with SMTP id u17so2412612iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 05:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Qc7lFNCTKln6OQu4srI6Xyqi6GuBxKNE2fl3UlOi/90=;
        b=spYZNtf60n2nJqYYLPBY75X4wjJqDiMiC77N6lFViBiYdnJTOzxrqZo/xPGDLW3GMu
         gIuu+Nuh9NIjBYOLVrINPGlBYexHSJvDNB9syW0UY7efVuQK2BUYKhCDlL4UJGFGHXbR
         sggs/QBZtgQvRvG+V3SB7GG//HBdh05hEC5xgt32AKxR8xSVkbrmgDeFpqrbPGknnibA
         mueOsNvxdFKsKhnoDhId+IDuJNFLZ3oFreWIOHekb3xTwaYqvomouzMPS2VWRsob6iNH
         4aBp1wqVJIf/1muVnuyzu7nWY1q1MwdMIe/5CE1RlwH+fnZF6iIPHGskifHlXRcNT8zY
         enCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Qc7lFNCTKln6OQu4srI6Xyqi6GuBxKNE2fl3UlOi/90=;
        b=sr7+2Evmr+6Bbks0bjyil60EMkVm1phDzuTRkna4Z2B5HPtawLvPUDp5V2bnhdcDfE
         /3bOFpkmKCEqetTswJYiO4S9sRV/y+sGQQAZ3WBYsze9VytumRInSoxoxIwj+HRuhY7x
         5RijmSHw7NHya25SyZLCMLAvAvw4IQwIjwcqcZ5aCeeJziIeI0Uztl8GLxhRIfF0ygAH
         xZMN3EkQDgDXQ/J+T3o3qLqvlYSylHy5H+noUNmVdLu0fSUn/Zv4Lk1cLTn+xujZaZtv
         1yxVEh91xSfeyIW8keQfmhEU7pgAz+PZ9wncE9UR+lb5bO7yuMJ6aY5fNhkZ+E/h/OtP
         Ug6g==
X-Gm-Message-State: ANhLgQ1obLJ6GbUNy7oWP+XbNQbqbx3qvqMWuhgpfGv2E3vNdbx/qPni
        WKGXThvbpG7Y+gXmspL48k3QGvCmBn5v0qYJl64=
X-Google-Smtp-Source: ADFU+vt0+nGSOu51T0zWGGS6FEB4GA1pelemaJmkPwfRuegMaKmVgzrokmwS2WdrLNuAzJPHgitonwNgA5fdxRyp+ew=
X-Received: by 2002:a5d:824c:: with SMTP id n12mr2237369ioo.234.1583329797349;
 Wed, 04 Mar 2020 05:49:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4f:fa1b:0:0:0:0:0 with HTTP; Wed, 4 Mar 2020 05:49:57 -0800 (PST)
Reply-To: dublonderic09@gmail.com
From:   Dublond Eric <dublond.eric1@gmail.com>
Date:   Wed, 4 Mar 2020 13:49:57 +0000
Message-ID: <CAEH0xdro7gOf9dyitwsbMbvPXq5hBFftJ0wCY-iXhjfi-_Ns9w@mail.gmail.com>
Subject: =?UTF-8?B?2KPZhtinINmF2K3Yp9mFINiv2YjYqNmE2YjZhtiv?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2KPZhtinINmF2K3Yp9mFINiv2YjYqNmE2YjZhtivDQrZhNmC2K8g2KPYsdiz2YTYqiDZhNmDINmH
2LDZhyDYp9mE2LHYs9in2YTYqSDZgtio2YQg2LTZh9ixINiMINmE2YPZhtmG2Yog2YTYs9iqINmF
2KrYo9mD2K/Zi9inINmF2YYg2KPZhtmDINit2LXZhNiqINi52YTZitmH2KcNCtiMINij2LHZitiv
2YMg2KPZhiDYqtmC2YEg2K7ZhNmB2YvYpyDZhNi52YXZitmE2Yog2KfZhNmF2KrZiNmB2Ykg2KfZ
hNiw2Yog2YPYp9mGINmF2YjYp9i32YbZi9inINmB2Yog2KjZhNiv2YMg2YjYo9mGINmK2K3ZhdmE
DQrZhtmB2LMg2KfZhNmE2YLYqCDZhdi52YMuINiq2YjZgdmKINmB2Yog2K3Yp9iv2Ksg2LPZitin
2LHYqSDZhdi5INi52KfYptmE2KrZhyDYjCDYqtin2LHZg9inINmF2KjZhNi62Kcg2YPYqNmK2LHY
pyDZhdmGDQrYp9mE2YXYp9mEINiMICjYq9mE2KfYq9ipINi52LTYsSDZhdmE2YrZiNmGINmI2K7Z
hdiz2YXYp9im2Kkg2YjYq9mF2KfZhtmI2YYg2KPZhNmBINiv2YjZhNin2LEpINmB2Yog2KfZhNio
2YbZgy4g2KjYudivDQrZhNit2LjYqSDZgdin2LTZhNipINmB2Yog2KfZhNio2K3YqyDYudmGINij
2YLYp9ix2KjZhyDYqNiz2KjYqCDYp9mE2KrZgdmI2YrYtiDYp9mE2LnYp9is2YQg2KfZhNiw2Yog
2YXZhtit2YbZiiDZhNiq2YLYr9mK2YUg2KPZig0K2YXZhiDYo9mC2KfYsdio2Ycg2YrYrdmF2YQg
2YbZgdizINin2YTZhNmC2Kgg2YTZhtmC2YQg2KfZhNij2YXZiNin2YQg2YjYp9mE2YXYt9in2YTY
qNipINio2YfYpyDYjCDZgtix2LHYqiDYp9mE2KfYqti12KfZhCDYqNmDLg0K2YjYs9ij2LnYt9mK
2YMg2KfZhNmF2LLZitivINmF2YYg2KfZhNiq2YHYp9i12YrZhCDYudmE2Ykg2KfZhNmG2K3ZiCDY
p9mE2KrYp9mE2Yo6INio2YXYrNix2K8g2KrZhNmC2Yog2LHYr9mD2YUg2KfZhNil2YrYrNin2KjZ
ii4NCg0K2KrZgdi22YTZiNinINio2YLYqNmI2YQg2YHYp9im2YIg2KfZhNin2K3Yqtix2KfZhdiM
DQrZhdit2KfZhSDYr9mI2KjZhNmI2YbYryDYp9ix2YrZgw0K
