Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7841178D65
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 10:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgCDJ1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 04:27:55 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34445 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgCDJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:27:55 -0500
Received: by mail-vs1-f68.google.com with SMTP id y204so705736vsy.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 01:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VZEGBpiDkfCJfVKzwvcrU7AdnezlOnsID6Ruzrh1lnM=;
        b=gk10CVjjm0ePJLE0dKFJfkQQhNb+tD4HwiwxUtW97n1ocUEZ5NAFegK2XL6yNDH+XE
         v4RrhbsTEPYgRzKPgt3ysQ5LQ6s3QJA7/GEREB7SlNbaWRA3+qI09+angsAanyhcIByP
         1qDfgBxq+wp8Bmd9kNfZKE6Lmr3Ene5Aqvutsb7/BNgisWmNRd5optR6WZCFrYKXlFH2
         R/MXTSchg8JUyJb1PLwvQuorkdYFQXiiOOqykjfdmArYEEJdlIK3ymGseMwbvVx4WAgi
         zmks55Xlpx8F/8AcNe436y8YmlCWj9f4yOpxSnSBYs7fKqCupffUJP7rM4tM9xBBkEFt
         t4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=VZEGBpiDkfCJfVKzwvcrU7AdnezlOnsID6Ruzrh1lnM=;
        b=sdJbPUWp/xFPnuFk2xyfc1oy+01wEC2524wjoGSMl/TcOVyM09BxzqMUSxQR7Svc/5
         TYShCzSVUYXE8ZPQ2VHIJWEbEv/z+KRktuUuZ54RjRppLxbGwyyyBxoiG/4AoM+Zi7fN
         5aBNLIxiRRf2U+gpxqF7hHSm0x0Py8+bNLPjFrBoNrqyiGoNCWbPeV22fjnRuhdZ2lV1
         9qmxZWQWUaSBpFOlxtw7GysxJzYLr3DBHL0n46bCm402xR487A6/ITNrXMntsMEXE2dx
         vUHsANkSUbCysfjSZuOSI7n7iZDe3/JM6lNnellObYm8f43zEumGAeN/xGfyeAbh9Jat
         EjtA==
X-Gm-Message-State: ANhLgQ1QMU+TQbvY1Jkde7onFZfa776W06ZjYBiUrXPwLeqA7vGzE5F+
        PZ47VBuO5xnC7gQup/s8TNsyS8c5z+NyeG9EJ0c=
X-Google-Smtp-Source: ADFU+vuAkFtihqzC7f6IJ3BTaYwR/KQiup/ankEaIY47XZH0fdgvezI/7G3g2x7EeIOl75F4/mPlLCKqB7S4k3rnWUk=
X-Received: by 2002:a67:f611:: with SMTP id k17mr1197095vso.143.1583314074283;
 Wed, 04 Mar 2020 01:27:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:7816:0:0:0:0:0 with HTTP; Wed, 4 Mar 2020 01:27:54 -0800 (PST)
Reply-To: aliuaeomar@gmail.com
From:   Ali Tarak Omar <info.eustace@gmail.com>
Date:   Wed, 4 Mar 2020 17:27:54 +0800
Message-ID: <CAPJpjN71gy0g4ChkNc4JMeG2aadkYH1WuNL5Bc327ArzMTrX4w@mail.gmail.com>
Subject: =?UTF-8?B?2KfZhNiz2YTYp9mFINi52YTZitmD2YU=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2YXYsdit2KjYp9mLINiMINij2YbYpyDYudmE2Yog2LfYp9ix2YIg2LnZhdixINiMINij2YbYpyDZ
hdiv2YrYsSDYqNmG2YMg2YfZhtinINmB2Yog2K/YqNmKLiDZhNmC2K8g2KfYqti12YTYqiDYqNmD
DQrYqNiu2LXZiNi1INit2LPYp9ioINmK2YXZhNmD2Ycg2YXZiNin2LfZhiDZhdmGINio2YTYr9mD
LiDYqtmI2YHZiiDZh9iw2Kcg2KfZhNix2KzZhCDZgtio2YQgMTIg2LnYp9mF2YvYpyDYjCDZiNmE
2YUg2YrYsNmD2LENCtij2Yog2LTYrti1INmI2LHYqyDYp9mE2LXZhtiv2YjZgi4g2KPYsNmGINmE
2Yog2KfZhNio2YbZgyDYqNin2YTYudir2YjYsSDYudmE2Ykg2KfZhNi52KfYptmE2Kkg2KfZhNiq
2KfZhNmK2Kkg2YTZhNi52YXZitmEDQrYp9mE2YXYqtmI2YHZiSDYjCDZhNmD2YbZhtmKINmE2YUg
2KPYrNiv2YfYpy4g2LPZitiq2YUg2KrYrNmF2YrYryDZh9iw2Kcg2KfZhNit2LPYp9ioINil2LDY
pyDZhNmFINmK2KrZgtiv2YUg2KPYrdivINio2LfZhNioDQrZhNmE2K3YtdmI2YQg2LnZhNmJINi1
2YbYr9mI2YIg2Iwg2YTYsNmE2YMg2YLYsdix2Kog2YXZhtin2YLYtNipINmH2LDYpyDYp9mE2YXZ
iNi22YjYuSDZhdmGINij2KzZhCDZhdi12YTYrdiq2YbYpw0K2KfZhNmF2KrYqNin2K/ZhNipINiM
INmE2YPZhtmKINmE2Kcg2KPYrdioINin2YTYrtmI2LYg2YHZiiDYp9mE2KrZgdin2LXZitmEINmH
2YbYpyDYjCDYqtit2KrYp9isINil2YTZiSDZg9iq2KfYqNipINmF2LLZitivDQrZhdmGINin2YTY
qtmB2KfYtdmK2YQg2YHZiiDYqNix2YrYr9mKINin2YTYpdmE2YPYqtix2YjZhtmKINin2YTYtNiu
2LXZiiDZiNij2YbYpyDYs9mI2YEg2YrYtNix2K0g2YTZhdin2LDYpyDZhNmKINio2K3Yp9is2KkN
CtmE2YXYs9in2LnYr9iq2YPZhS4NCihhbGl1YWVvbWFyQGdtYWlsLmNvbSkNCg0K2YXYuSDYqtit
2YrYp9iq2YrYjA0K2LnZhNmKINi32KfYsdmCINi52YXYsQ0K
