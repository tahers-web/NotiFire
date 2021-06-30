INSPIRATION:

Based on recent studies and statistics, it has been observed that there is a constant rise in the death rate due to fire accidents. Even in countries like Japan and USA, considered to be the front runners for the use of sophisticated safety equipment in their buildings have seen a 4% increase, in last 3 years.

A pilot study was conducted which covered 6 major GCC countries to understand the fire safety mechanism that is prevalent in the region. A total of 487 respondents participated in the survey in age brackets of 18-24, 25-39, 40-60 and 60+. The majority of respondents belonged to the 25 to 60 range.

The analytical research gave insights in identifying the gaps within the system. The major challenge being ignoring a fire alarm during a breakout under the pretext of assuming it to be a false alarm. This finding is supported by 71% of the respondents followed by 83% vouching to be notified digitally.

The United Arab Emirates’ Vision for 2021 and the National Agenda 2030 for UAE primarily considers sustainable environment and infrastructure as one of its pillars. In line of this, UAE has implemented “Hassantuk” – A smart fire detection system with end-to-end wireless fire safety solution, which connects the fire system to the civil defense.

Despite having such advanced smart systems, the challenge of residents responding to a fire alarm in a timely manner still remains a question. This critical gap is not just a technological gap but prevails due to the psychological mindset of the dwellers misunderstanding every buzz of the fire alarm to be a false alarm. This gap needs to be addressed by implementation of a smart level based system to detect and notify a fire breakout based according to the intensity.


HOW IT WORKS:

NotiFire comprises of alarm initiating sensor based devices - smoke detectors/gas sensors, flame sensors, and alarm based devices - speakers, buzzers, and led bulbs. The sensors are programmed to detect levels of heat or smoke that could indicate a fire and generate an appropriate alert notification message based on the intensity of fire. The Raspberry pi is connected to the flame and gas sensors through jumper cables and with suitable API, to fetch data and store in the Firebase. 

NotiFire can distinguish between three intensity levels of fire and gas. On the perspective of detecting a fire breakout via flame sensor, a range less than 50 V, is classified as Level 1, between 50 V and 200 V is Level 2, and between 200 V and 512 V is Level 3. In terms of smoke detection, if the gas sensor detects a range less than 50 V it is classified as Level 3, between 50 V and 200 V is level 2, and between 200 V and 512 V is level 1. 

The NotiFire app is linked to the Firebase, using appropriate API; In terms of a scenario of sending a notification, data is retrieved from Firebase and notification is sent to tenants, owners, and other personnel and regulatory authorities as per the levels.


DESIGN PROCESS:

Ideation ran in parallel with research investigating potential solutions to fill market gaps with an objective to apply the research findings. The design process ran in three streams allowing each part to influence one another; the physical design for the case, the hardware components and the application interface. The base was designed through a trial-and-error approach and extensive testing. First, through literature survey, analysis, and selecting the appropriate sensors which were ideal for this line of functionality. Then, a series of prototypes were developed, with each design iteration having different focus areas, with gradual improvements. 

As for the application perspective, initially there was a lot of speculation on how to make it available on different mobile operating systems and finally flutter was finalized which enables cross platform functionality. The interaction prototypes incorporated the software and electronics subsystems, leading to a unique serviceability for the residents. After numerable iterations and trials, the text service was successfully brought to a workable stage, despite the restrictions imposed by the regulatory authorities in United Arab Emirates. The final product included a well functioning app, with assorted slots for all the electronic components and a well designed and sustainable fire alarm case to incorporate the proposed idea.

HOW IT IS DIFFERENT:

NotiFire stands out as a novel idea that addresses the pain points that exist in the current system. It is one of a kind solution that incorporates levels of fire detection with notifications. It analyzes and detects the level of threat prior to the mode of notification and accordingly alerts the inhabitants in case of a fire breakout, which is not practiced in any smart fire system till date to our knowledge.

The app also includes a feature for tenants having school going children where in it notifies the school in case of an emergency such that the kids are kept back at school till the situation is handled. The app also has a virtual STOP button which replaces the hassle of manually resetting the alarm irrespective of the level of breakout. 

This functionality of notifying ensures the safety to the dwellers even if they are away from home in the occurrence of a mishap with slight anomalies in temperature and humidity readings that can be controlled.

Thus, NotiFire creates a functional design with strong user experience.


FUTURE PLANS:

NotiFire aims to enhance the quality of living in terms of a smart cost effective, timely notification system with an objective to minimize the risk to human life and property amidst a fire breakout.

The team aspires to secure a grant and take the prototype to the next level giving it a form of a working model by enhancing the workflow with AI, ML techniques and integrating it with a virtual assistant in the future with proper testing and patent the product.

This capital would facilitate further development of the technology, with continued dynamic testing and expansion of the application that will use AI integrated thermal camera, which can guide tenants with instructions on how to put out the fire depending on the level of outbreak.
The plan is also to add features such as a geolocational ultra-wideband direction guide, which will help the dwellers to evacuate safely through an ideal escape route in case of a fire breakout.

The physical design of NotiFire would be iterated, focusing on reducing its size, and getting a custom PCB for the better implementation of sensors, making it less obtrusive. These steps would eventually allow it to reach clinical trials, a critical stage before hitting the market.

One of the aspects the team intends in improvising the most is to cater the needs of majority of regions in the world, hence making it customizable according to the country it is deployed in. This can be put forth with global advancements based on regions.

Quality standards can be improved a lot as well, just by analyzing the situation well, and working on the co-existing models for fire safety; Eg: “Hassantuk” an initiative by UAE govt. to notify and send out SOS to civil defense in case of fire related emergencies. This would enhance the standard of living, which is one of the prime goals, besides reducing the cost, minimizing property damage and aspiring to save lives. 
