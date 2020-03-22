Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D39618EA8F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 17:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCVQlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 12:41:24 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:37353 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVQlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:41:24 -0400
Received: by mail-vs1-f43.google.com with SMTP id o3so7185171vsd.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GE0sTIPTcm1eIKlinbf+AFAt+kbfaQDYpKx4gSVAaIA=;
        b=T46M0q8X0j2xrlvo/brjcErDb3qz8V0F1/aoOyCJTTZMRldI3kZV/hx3lx381qvWH5
         IJsqgLTRoxOo4O1SO4uXV08FNAZW0S5xE5u+w5wjVHIpgzZYqD7f0wDJRgvidPuQdtTI
         rgcsBj3INLKXntZ57/iVJYBMCJZGJ5YqshtIMZLdfHIb/l5VZYzMI+74W5JXWbMYf03I
         Td+5OXUMmecioltNyJQhhyNhXaPcxMtVSI/zNitGfg+1TRj4YoSVA8+5G3bsxtDMW8Fx
         TvZWAzat6W+TBeSLCPYoCwU/wsUKWqFhqRpBcqdGl479JJBrQtWaDYiEbSQkE7XutrIT
         RZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GE0sTIPTcm1eIKlinbf+AFAt+kbfaQDYpKx4gSVAaIA=;
        b=YKOprOHKdbE+6gLiLI2NZyvyg6303899VCl0t76Fhlbpm4h7DlXSnX9v/aQkq8viq9
         auaZh0Ewujc/HyHo1xGOqkhN/tOfkgTa6UsIW5n5vEzwQDb7KSYB3AYP831DBIKZ1z3W
         DRulNL5gw66gTkYoQzPY9Cm9a7gqavcVOfMq0/Ktv+lpDbmUHt0WDqc12ZkeXI1nbOgy
         IkPh/T1p4UQul4/BAyTct/jlEGzCSatkpLmO7t3GFXraLfWEMJI/W+zX+gRiKYp7LTHS
         zdbeFxObiFtjzJl1fF9iCp9oWLBf//ueyi1W4j7V5eptL3uETT3oM+RmKF4Mj54XGkBK
         IoYw==
X-Gm-Message-State: ANhLgQ2Lv8SVFFDyeBoF7G4maBKhxqMDntsAEuGHIMWKLTOAReIr8lIW
        1cFsBAQFmGxrRS5G3TjWavkzaRXCTKoPE26e+DsDHvrpdxU=
X-Google-Smtp-Source: ADFU+vuPGVj8OS7DKgC7334rvI4ih03X3uGRbn3FZzcZRr/5KK69Ggp2o/FTr6h1vyeAt9uaxtsnKDd+TckMLgWBsW0=
X-Received: by 2002:a05:6102:5ee:: with SMTP id w14mr12204529vsf.135.1584895281541;
 Sun, 22 Mar 2020 09:41:21 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?David_Bala=C5=BEic?= <xerces9@gmail.com>
Date:   Sun, 22 Mar 2020 17:41:10 +0100
Message-ID: <CAPJ9Yc-rAOai0rqpgcGv25opNVUkxAKdJBpjAvMrg-moXS3hAg@mail.gmail.com>
Subject: Oops and panic - how to debug?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(I'm not subscribed, please CC me)

I got a load of kernel errors running sysrescCD 6.1.1 64 bit on my HP
Microserver (N36L) and wonder where to proceed.

I loaded the photos of the messages here :
https://gitlab.com/fdupoux/sysresccd-src/-/issues/87

Is this something someone here can help with?

The issue raises the suspicion of a hardware problem, but Windows
2012R2 and some other (mostly older) linux distros seem to work fine.

Regards,
David
