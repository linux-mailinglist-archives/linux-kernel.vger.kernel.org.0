Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1A9A43D9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 11:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfHaJ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 05:58:15 -0400
Received: from sender4-pp-o93.zoho.com ([136.143.188.93]:25354 "EHLO
        sender4-pp-o93.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHaJ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 05:58:15 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Aug 2019 05:58:14 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1567244589; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=jDIHexwKyOZO4WTIfjWayng7cZ7k2zQr0s9krLwFhObM1eWeDOddRXMZbu3ZtJM8n/spWSbmXscIFlGgkLpE0aCIwDOiG3bV059nD8GAYVESX+iwQjt4ouTaJZPTaOJgwZaAFmRF/XZSpVWC3OpLsOKHYbDCscc61YojJ5wepXc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1567244589; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=xa9Mjn0mckJ2Ick178hK+v7PjRClIBQVucPVeCxwYJg=; 
        b=XXkadnaz4uVp85O45LdocJiZcKWAxDvR7GP3b/rPmwqXDqbGv4a44oMwC4c2aHt3BohWn3cnm3oZQed1YcdQDJ4Jz7J9ODVMGz+p+7PP3Akwc7g67yJLnAwg6FnZll/jgpiRgk1aC7bTYY3MlEq7OacV+Vz3xw/m/b4RBotSHaE=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=ovari123@zoho.com;
        dmarc=pass header.from=<ovari123@zoho.com> header.from=<ovari123@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=to:from:message-id:subject:date:user-agent:mime-version:content-type; 
  b=Z1kgin7OdFXYPiqRh7U4B3oKfyB+EwCpAlznQD9iiuD1/owBy3wSLsHafQw47qLuOsHRGwHZnSPd
    Gl3i/SdzC8bTPtaweZ//Qzqu30OdqYYKiKWdSZCKcab8Y8cnDFtH  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1567244589;
        s=zm2019; d=zoho.com; i=ovari123@zoho.com;
        h=To:From:Message-ID:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=290; bh=xa9Mjn0mckJ2Ick178hK+v7PjRClIBQVucPVeCxwYJg=;
        b=FtH8FCflEEMA48zVrikyRm6pwq8oKlRK2lYnNLVJwKrGZzx/ywFU6P7VBtX0R2dO
        UY4llhjxDw6lLspypOkk1bV9HWJUhtHxLvwpRQI1SlAoeSx8LmBy3CnEv3buSZEKnXd
        ULOl2ocNLIQLySUmeesAtBDOsUoL1G7BeANWEteM=
Received: from [192.168.1.3] (103.55.93.99 [103.55.93.99]) by mx.zohomail.com
        with SMTPS id 1567244588668115.92537005305758; Sat, 31 Aug 2019 02:43:08 -0700 (PDT)
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   =?UTF-8?B?w5N2w6FyaQ==?= <ovari123@zoho.com>
Message-ID: <d355e790-7c60-5681-3ea5-dc4fd6206628@zoho.com>
Subject: Asus VivoBook Flip TP202NA-EH012T EMMC problem
Date:   Sat, 31 Aug 2019 19:43:04 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-AU
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As per https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1818407/comment=
s/26 here is an email.

Information is provided at https://bugs.launchpad.net/ubuntu/+source/linux/=
+bug/1818407/comments/32

Please advise what else you require.

Thank you

=C3=93v=C3=A1ri



