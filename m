Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C46C79C31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 00:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfG2WHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 18:07:23 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:42608 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfG2WHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:07:22 -0400
Received: by mail-pf1-f179.google.com with SMTP id q10so28689715pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=csEhxLftm+HOi0h8WDYUxpEh66b7wqPuhhJ7wGnIWeg=;
        b=qxDYSlPjKqWHcwlSvPAsDXcdiw2ybEg2jjNr6DKxy7fWg0z+jarVGVRzSdPxQcAhf3
         TU04k2kTEUcgZI/wGsXDvnxgIG/XJSaiDofEQr25ge5O8wLkPlkN1w9yOODMOUqqgGiH
         z/JGUZ9Y6Zo82tKpjKEM6G8R/oqBMnpGsPdBpt7tCUFaC1AKJKZzi8IMPAF4jKa6cWy5
         c466FdS4As7UEebIlsgObWaQEM8wuena80fo9gdqTlEhL6e/WiJN7W06/jk5D8o5ZfdU
         DcIirzSkG72SeXwwfIAisrmPMbI8YZNzzPvztg1QDRXR+9EKxE6xd+mxuSLMgy9mW/fF
         mzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=csEhxLftm+HOi0h8WDYUxpEh66b7wqPuhhJ7wGnIWeg=;
        b=DCO/rZtvJ/N5pn6tCJuJUayG7GMk0RIZlPCig2cJNKzkjq6nmbG8FjzqzRJhD3XPrg
         LRtDNmykvadsqiAVCQySJPOhKZbDhr/E4/ox2sR8lR75/RMFcSlIPHZv1EnJx0qARA6V
         jJC3PsUNBzJZYcd02pOxxHI9IKavMy7MG7veHFGqw1rfSM/VUDweZBGMvUyO4jVGb8yN
         cs7+whEvkyy9uOgvAYG6lTfsJHgP1Tux4nlQSvMsFo2aSB6iOHQaUJOlnHgpxglaPc4E
         b7gr4gou4SIcKVOUCClTDUvc2xYtTU7e6m0T5COzn4rFJj6CW/qDwoGBhuYGgL9WkC7N
         5iJw==
X-Gm-Message-State: APjAAAU3/rPtjIBLKX3NkCm/2Wx8kRp5Tnfdct6CSXGk2feOZ6bYVzDO
        26BS1j/Imcl8KWghkBPfVN4NZBP7
X-Google-Smtp-Source: APXvYqy+fiSM1sC5N3thhf3zINCDo5cQcHTdmcwVySQxhYkSz12+fM9TXllRK0p5O5agVoX999R+Xg==
X-Received: by 2002:a62:ce07:: with SMTP id y7mr37274948pfg.12.1564438042436;
        Mon, 29 Jul 2019 15:07:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 30sm145730310pjk.17.2019.07.29.15.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 15:07:21 -0700 (PDT)
Date:   Mon, 29 Jul 2019 15:07:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-watchdog@cger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Marking legacy watchdog drivers as deprecated / obsolete
Message-ID: <20190729220720.GB5712@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we have recently seen a number of changes to legacy watchdog drivers,
mostly surrounding the coding style used some 10+ years ago, but also
fixing minor formatting or coding problems found by static analyzers.
This slowly rises above the level of background noise.

Would it be acceptable to mark all those drivers as deprecated/obsolete,
warn users that the driver should be converted to use the watchdog
subsystem, and that it will otherwise be removed in a later Linux kernel
version ? This would give us an idea which drivers are still in use,
and it would enable us to remove the remaining drivers maybe 5 or 6
releases for now.

Thoughts ?

Guenter
